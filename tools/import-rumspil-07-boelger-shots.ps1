<#
  Henter skærmbillederne til rumspillets lektion 07-boelger ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-07-boelger.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs07",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\07-boelger\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-niveau-variable.png";   Name = "01-niveau-variable.png";   Mask = @() }
  @{ From = "02-niveautekst.png";       Name = "02-niveautekst.png";       Mask = @() }
  @{ From = "03-tween-search.png";      Name = "03-tween-search.png";      Mask = @() }
  @{ From = "04-tween-added.png";       Name = "04-tween-added.png";       Mask = @() }
  @{ From = "05-niveau-timer.png";      Name = "05-niveau-timer.png";      Mask = @() }
  @{ From = "06-niveau-plus.png";       Name = "06-niveau-plus.png";       Mask = @() }
  @{ From = "07-niveau-text.png";       Name = "07-niveau-text.png";       Mask = @() }
  @{ From = "08-tween.png";             Name = "08-tween.png";             Mask = @() }
  @{ From = "09-asteroide-time.png";    Name = "09-asteroide-time.png";    Mask = @() }
  @{ From = "11-pointtekst.png";        Name = "10-pointtekst.png";        Mask = @() }
  @{ From = "12-layers-panel.png";      Name = "11-layers-button.png";     Mask = @() }
  @{ From = "13-gui-layer.png";         Name = "12-gui-layer.png";         Mask = @() }
  @{ From = "14-pointtekst-gui.png";    Name = "13-pointtekst-gui.png";    Mask = @() }
  @{ From = "15-events-top.png";        Name = "14-events-top.png";        Mask = @() }
  @{ From = "16-events-bottom.png";     Name = "15-events-bottom.png";     Mask = @() }
  @{ From = "pv-02.png";                Name = "16-preview-wave2.png";     Mask = @() }
  @{ From = "pv-layer-check.png";       Name = "17-preview-gui.png";       Mask = @() }
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
