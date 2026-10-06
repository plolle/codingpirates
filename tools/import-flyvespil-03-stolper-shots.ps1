<#
  Henter skærmbillederne til flyvespillets lektion 03-stolper ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - maskerer e-mailadressen i den øverste bjælke, så den ikke bliver offentliggjort
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-flyvespil-03-stolper.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\fs03",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\flyvespil\03-stolper\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-pack-terrain.png";       Name = "01-pack-terrain.png";       Mask = @() }
  @{ From = "02-terrain-folder.png";     Name = "02-terrain-folder.png";     Mask = @() }
  @{ From = "03-grass-asset.png";        Name = "03-grass-asset.png";        Mask = @() }
  @{ From = "look-added.png";            Name = "04-object-added.png";       Mask = @() }
  @{ From = "07-stolpe-size.png";        Name = "05-stolpe-size.png";        Mask = @() }
  @{ From = "08-search-beginning.png";   Name = "06-search-beginning.png";   Mask = @() }
  @{ From = "09-start-timer.png";        Name = "07-start-timer.png";        Mask = @() }
  @{ From = "10-timer-condition.png";    Name = "08-timer-condition.png";    Mask = @() }
  @{ From = "11-create-bottom.png";      Name = "09-create-bottom.png";      Mask = @() }
  @{ From = "12-create-top.png";         Name = "10-create-top.png";         Mask = @() }
  @{ From = "13-force.png";              Name = "11-force.png";              Mask = @() }
  @{ From = "14-x-less.png";             Name = "12-x-less.png";             Mask = @() }
  @{ From = "15-delete.png";             Name = "13-delete.png";             Mask = @() }
  @{ From = "16-all-events.png";         Name = "14-all-events.png";         Mask = @() }
  @{ From = "pv-1.png";                  Name = "15-preview.png";            Mask = @() }
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
