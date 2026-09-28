<#
  Henter skærmbillederne til rumspillets lektion 03-asteroider ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-03-asteroider.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs03",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\03-asteroider\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-meteors-folder.png";     Name = "01-meteors-folder.png";     Mask = @() }
  @{ From = "02-meteor-asset.png";       Name = "02-meteor-asset.png";       Mask = @() }
  @{ From = "03-asteroide-in-list.png";  Name = "03-asteroide-in-list.png";  Mask = @() }
  @{ From = "04-asteroide-destroy.png";  Name = "04-asteroide-destroy.png";  Mask = @() }
  @{ From = "05-from-scratch.png";       Name = "05-from-scratch.png";       Mask = @() }
  @{ From = "06-search-text.png";        Name = "06-search-text.png";        Mask = @() }
  @{ From = "09-text-settings.png";      Name = "07-text-settings.png";      Mask = @() }
  @{ From = "08-color-white.png";        Name = "08-color-white.png";        Mask = @() }
  @{ From = "10-text-placed.png";        Name = "09-text-placed.png";        Mask = @() }
  @{ From = "11-scene-variable.png";     Name = "10-scene-variable.png";     Mask = @() }
  @{ From = "12-second-timer.png";       Name = "11-second-timer.png";       Mask = @() }
  @{ From = "14-create-asteroide.png";   Name = "12-create-asteroide.png";   Mask = @() }
  @{ From = "15-asteroide-force.png";    Name = "13-asteroide-force.png";    Mask = @() }
  @{ From = "16-asteroide-event.png";    Name = "14-asteroide-event.png";    Mask = @() }
  @{ From = "17-collision.png";          Name = "15-collision.png";          Mask = @() }
  @{ From = "18-delete-laser.png";       Name = "16-delete-laser.png";       Mask = @() }
  @{ From = "19-add-points.png";         Name = "17-add-points.png";         Mask = @() }
  @{ From = "20-rotate.png";             Name = "18-rotate.png";             Mask = @() }
  @{ From = "21-text-action.png";        Name = "19-text-action.png";        Mask = @() }
  @{ From = "22-events-done.png";        Name = "20-events-done.png";        Mask = @() }
  @{ From = "pv-2.png";                  Name = "21-preview.png";            Mask = @() }
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
