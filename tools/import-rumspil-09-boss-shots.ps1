<#
  Henter skærmbillederne til rumspillets lektion 09-boss ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-09-boss.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs09",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\09-boss\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-powerups-folder.png";   Name = "01-powerups-folder.png";   Mask = @() }
  @{ From = "04-lynskud.png";           Name = "02-lynskud.png";           Mask = @() }
  @{ From = "06-variables.png";         Name = "03-variables.png";         Mask = @() }
  @{ From = "07-skudtid.png";           Name = "04-skudtid.png";           Mask = @() }
  @{ From = "21-events-powerups.png";   Name = "05-events-powerups.png";   Mask = @() }
  @{ From = "05-boss-asset.png";        Name = "06-boss-asset.png";        Mask = @() }
  @{ From = "08-scale.png";             Name = "07-scale.png";             Mask = @() }
  @{ From = "09-boss-x.png";            Name = "08-boss-x.png";            Mask = @() }
  @{ From = "20-events-top.png";        Name = "09-events-top.png";        Mask = @() }
  @{ From = "22-events-boss.png";       Name = "10-events-boss.png";       Mask = @() }
  @{ From = "pv-rapidfire.png";         Name = "11-preview-lynskud.png";   Mask = @() }
  @{ From = "pv-boss-fight.png";        Name = "12-preview-boss.png";      Mask = @() }
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
