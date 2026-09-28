<#
  Henter skærmbillederne til rumspillets lektion 08-menu-highscore ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-08-menu-highscore.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs08",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\08-menu-highscore\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "02-scene-menu.png";          Name = "01-scene-menu.png";         Mask = @() }
  @{ From = "04-start-scene.png";         Name = "02-start-scene.png";        Mask = @() }
  @{ From = "05-global-highscore.png";    Name = "03-global-highscore.png";   Mask = @() }
  @{ From = "06-bgcolor.png";             Name = "04-bgcolor.png";            Mask = @() }
  @{ From = "07-titeltekst.png";          Name = "05-titeltekst.png";         Mask = @() }
  @{ From = "08-menu-layout.png";         Name = "06-menu-layout.png";        Mask = @() }
  @{ From = "09-exists.png";              Name = "07-exists.png";             Mask = @() }
  @{ From = "10-load.png";                Name = "08-load.png";               Mask = @() }
  @{ From = "19-just-pressed.png";        Name = "09-just-pressed.png";       Mask = @() }
  @{ From = "12-change-scene.png";        Name = "10-change-scene.png";       Mask = @() }
  @{ From = "20-menu-events.png";         Name = "11-menu-events.png";        Mask = @() }
  @{ From = "14-igen-create.png";         Name = "12-igen-create.png";        Mask = @() }
  @{ From = "15-point-gt-highscore.png";  Name = "13-point-gt-highscore.png"; Mask = @() }
  @{ From = "16-highscore-set.png";       Name = "14-highscore-set.png";      Mask = @() }
  @{ From = "17-save.png";                Name = "15-save.png";               Mask = @() }
  @{ From = "18-spil-events-bottom.png";  Name = "16-spil-events.png";        Mask = @() }
  @{ From = "pv-10-menu-saved.png";       Name = "17-preview-menu.png";       Mask = @() }
  @{ From = "pv-02-gameover.png";         Name = "18-preview-rekord.png";     Mask = @() }
)

foreach ($m in $map) {
  $file = Join-Path $Src $m.From
  if (-not (Test-Path $file)) { Write-Warning "Fandt ikke kilden $($m.From)"; continue }

  $img = [System.Drawing.Image]::FromFile($file)
  $bmp = New-Object System.Drawing.Bitmap $img.Width, $img.Height
  $g   = [System.Drawing.Graphics]::FromImage($bmp)
  $g.DrawImage($img, 0, 0, $img.Width, $img.Height)

  $masked = 0
  foreach ($spec in @($m.Mask)) {
    if (-not $spec) { continue }
    $p = $spec -split '\s*,\s*'
    if ($p.Count -ne 4) { throw "Ugyldig maske '$spec' for $($m.Name)" }
    $x = [int]$p[0]; $y = [int]$p[1]; $w = [int]$p[2]; $h = [int]$p[3]
    # Tag baggrundsfarven lige til venstre for feltet, saa maskeringen falder i et
    $bg = $bmp.GetPixel([Math]::Max(0, $x - 14), $y + [int]($h / 2))
    $brush = New-Object System.Drawing.SolidBrush $bg
    $g.FillRectangle($brush, $x, $y, $w, $h)
    $brush.Dispose()
    $masked++
  }

  $g.Dispose(); $img.Dispose()
  $out = Join-Path $dest $m.Name
  $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
  "{0,-28} <- {1}  ({2} x {3}){4}" -f $m.Name, $m.From, $bmp.Width, $bmp.Height, $(if ($masked) { "  [$masked omraade(r) maskeret]" } else { "" })
  $bmp.Dispose()
}
