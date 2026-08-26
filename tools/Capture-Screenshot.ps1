<#
.SYNOPSIS
  Tager et skærmbillede og gemmer det direkte i den rigtige lektionsmappe.

.DESCRIPTION
  Beregnet til at optage nye skærmbilleder til GDevelop-kurset. Du stiller GDevelop
  op som billedet skal se ud, og scriptet fanger skærmen efter en nedtælling.

  Med -Window fanges kun det aktive vindue i stedet for hele skærmen.

.PARAMETER Lesson
  Lektionsmappen, fx "01-intro" eller "02-begynder".

.PARAMETER Name
  Filnavnet uden .png, fx "01-create-a-project".

.PARAMETER Delay
  Sekunder at vente, så du kan klikke over i GDevelop først. Standard 5.

.EXAMPLE
  .\Capture-Screenshot.ps1 -Lesson 01-intro -Name 01-create-a-project -Delay 6 -Window
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Lesson,
  [Parameter(Mandatory)][string]$Name,
  [int]$Delay = 5,
  [switch]$Window,
  [string]$Root = "c:\Sandbox\Privat\codingpirates\gdevelop"
)

Add-Type -AssemblyName System.Windows.Forms, System.Drawing

Add-Type -Namespace Win32 -Name Native -MemberDefinition @'
  [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
  [StructLayout(LayoutKind.Sequential)] public struct RECT { public int L, T, R, B; }
  [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
'@

$dir = Join-Path (Join-Path $Root $Lesson) "images"
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
$out = Join-Path $dir "$Name.png"

if ($Delay -gt 0) {
  Write-Host "Stil GDevelop op nu. Optager om..." -ForegroundColor Yellow
  for ($i = $Delay; $i -gt 0; $i--) { Write-Host "  $i" -ForegroundColor Yellow; Start-Sleep -Seconds 1 }
}

if ($Window) {
  $h = [Win32.Native]::GetForegroundWindow()
  $r = New-Object Win32.Native+RECT
  [void][Win32.Native]::GetWindowRect($h, [ref]$r)
  $x = $r.L; $y = $r.T; $w = $r.R - $r.L; $h2 = $r.B - $r.T
} else {
  $b = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
  $x = $b.X; $y = $b.Y; $w = $b.Width; $h2 = $b.Height
}

if ($w -le 0 -or $h2 -le 0) { throw "Kunne ikke bestemme området ($w x $h2)" }

$bmp = New-Object System.Drawing.Bitmap $w, $h2
$g   = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($x, $y, 0, 0, $bmp.Size)
$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()

"OK  $out  ($w x $h2)"
