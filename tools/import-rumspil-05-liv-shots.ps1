<#
  Henter skærmbillederne til rumspillets lektion 05-liv ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-05-liv.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs05",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\05-liv\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-search-healthbar.png";   Name = "01-search-healthbar.png";   Mask = @() }
  @{ From = "02-healthbar-fill.png";     Name = "02-healthbar-fill.png";     Mask = @() }
  @{ From = "03-healthbar-placed.png";   Name = "03-healthbar-placed.png";   Mask = @() }
  @{ From = "04-liv-variable.png";       Name = "04-liv-variable.png";       Mask = @() }
  @{ From = "09-bar-width.png";          Name = "05-bar-width.png";          Mask = @() }
  @{ From = "06-skib-collision.png";     Name = "06-skib-collision.png";     Mask = @() }
  @{ From = "07-liv-minus.png";          Name = "07-liv-minus.png";          Mask = @() }
  @{ From = "08-hit-sound.png";          Name = "08-hit-sound.png";          Mask = @() }
  @{ From = "05-gameover-text.png";      Name = "09-gameover-text.png";      Mask = @() }
  @{ From = "10-liv-zero.png";           Name = "10-liv-zero.png";           Mask = @() }
  @{ From = "11-trigger-once.png";       Name = "11-trigger-once.png";       Mask = @() }
  @{ From = "13-z-order.png";            Name = "12-z-order.png";            Mask = @() }
  @{ From = "12-liv-above-zero.png";     Name = "13-liv-above-zero.png";     Mask = @() }
  @{ From = "14-events-done.png";        Name = "14-events-done.png";        Mask = @() }
  @{ From = "pv-03.png";                 Name = "15-preview-hit.png";        Mask = @() }
  @{ From = "pvz-end.png";               Name = "16-preview-gameover.png";   Mask = @() }
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
