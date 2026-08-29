<#
.SYNOPSIS
  Tager et skærmbillede af ET BESTEMT vindue - uden at hive det frem i forgrunden.

.DESCRIPTION
  Bruger PrintWindow med PW_RENDERFULLCONTENT, så vinduet kan fotograferes selvom
  det ligger bag andre vinduer. Det betyder, at man kan arbejde videre i et andet
  program imens, uden at ødelægge billedet.

  Gemmer som PNG i fuld opløsning - ingen JPEG-komprimering.

.PARAMETER Match
  Del af vinduets titel, fx "GDevelop". Første vindue der matcher, bruges.

.PARAMETER Out
  Filnavn der skrives til. Mapper oprettes efter behov.

.PARAMETER List
  Viser blot alle synlige vinduer med titel og størrelse, og stopper.

.EXAMPLE
  .\Capture-Window.ps1 -List

.EXAMPLE
  .\Capture-Window.ps1 -Match "GDevelop" -Out ".\gdevelop\01-intro\images\02-start-screen.png"
#>
[CmdletBinding()]
param(
  [string]$Match,
  [string]$Out,
  [switch]$List,
  [string]$Exclude = "Google Chrome",
  [int]$SettleMs = 700
)

Add-Type -AssemblyName System.Drawing, System.Windows.Forms

Add-Type -Namespace Cap -Name Win -MemberDefinition @'
  [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
  [DllImport("user32.dll")] public static extern int GetWindowTextLength(IntPtr h);
  [DllImport("user32.dll", CharSet=CharSet.Unicode)] public static extern int GetWindowText(IntPtr h, System.Text.StringBuilder s, int n);
  [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr h, IntPtr hdc, uint flags);
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
  [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
  [StructLayout(LayoutKind.Sequential)] public struct RECT { public int L, T, R, B; }
  [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
  public delegate bool EnumProc(IntPtr h, IntPtr p);
  [DllImport("user32.dll")] public static extern bool EnumWindows(EnumProc cb, IntPtr p);
'@

$found = New-Object System.Collections.ArrayList
$cb = [Cap.Win+EnumProc]{
  param($h, $p)
  if ([Cap.Win]::IsWindowVisible($h)) {
    $len = [Cap.Win]::GetWindowTextLength($h)
    if ($len -gt 0) {
      $sb = New-Object System.Text.StringBuilder ($len + 1)
      [void][Cap.Win]::GetWindowText($h, $sb, $sb.Capacity)
      $r = New-Object Cap.Win+RECT
      [void][Cap.Win]::GetWindowRect($h, [ref]$r)
      $w = $r.R - $r.L; $ht = $r.B - $r.T
      if ($w -gt 200 -and $ht -gt 200) {
        [void]$found.Add([pscustomobject]@{ H = $h; Title = $sb.ToString(); W = $w; H2 = $ht })
      }
    }
  }
  return $true
}
[void][Cap.Win]::EnumWindows($cb, [IntPtr]::Zero)

if ($List) {
  $found | ForEach-Object { "{0,-70} {1} x {2}" -f $_.Title, $_.W, $_.H2 }
  return
}

if (-not $Match -or -not $Out) { throw "Angiv baade -Match og -Out (eller brug -List)" }

$candidates = $found | Where-Object { $_.Title -like "*$Match*" }
if ($Exclude) { $candidates = $candidates | Where-Object { $_.Title -notlike "*$Exclude*" } }
$win = $candidates | Select-Object -First 1
if (-not $win) {
  "Fandt ikke noget vindue der matcher '$Match' (uden '$Exclude'). Synlige vinduer:"
  $found | ForEach-Object { "  " + $_.Title }
  throw "Intet match"
}

# PrintWindow giver et sort billede for Chromium/Electron-vinduer, saa vi henter
# vinduet frem et oejeblik og fotograferer skaermen i stedet.
$prev = [Cap.Win]::GetForegroundWindow()
[void][Cap.Win]::ShowWindow($win.H, 9)   # 9 = SW_RESTORE
[void][Cap.Win]::SetForegroundWindow($win.H)
Start-Sleep -Milliseconds $SettleMs

# Hent koordinaterne igen - vinduet kan have flyttet sig da det kom frem
$r2 = New-Object Cap.Win+RECT
[void][Cap.Win]::GetWindowRect($win.H, [ref]$r2)
$x = $r2.L; $y = $r2.T; $w = $r2.R - $r2.L; $h2 = $r2.B - $r2.T

$bmp = New-Object System.Drawing.Bitmap $w, $h2
$g   = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($x, $y, 0, 0, $bmp.Size)
$g.Dispose()

# Giv fokus tilbage til det vindue der havde det foer
if ($prev -ne [IntPtr]::Zero -and $prev -ne $win.H) {
  [void][Cap.Win]::SetForegroundWindow($prev)
}

$win = [pscustomobject]@{ H = $win.H; Title = $win.Title; W = $w; H2 = $h2 }

# Tjek at billedet ikke bare er sort (sker hvis PrintWindow ikke understoettes)
$sample = @(); $rand = 0
foreach ($p in @(@(0.25,0.25),@(0.5,0.5),@(0.75,0.4),@(0.5,0.8))) {
  $sample += $bmp.GetPixel([int]($bmp.Width * $p[0]), [int]($bmp.Height * $p[1])).ToArgb()
}
$distinct = ($sample | Sort-Object -Unique).Count

$dir = Split-Path -Parent $Out
if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
$bmp.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()

"OK  '{0}'  ->  {1}  ({2} x {3}, {4} unikke proevepunkter)" -f $win.Title, $Out, $win.W, $win.H2, $distinct
if ($distinct -le 1) { Write-Warning "Billedet ser ensfarvet ud - vinduet blev maaske ikke tegnet korrekt." }
