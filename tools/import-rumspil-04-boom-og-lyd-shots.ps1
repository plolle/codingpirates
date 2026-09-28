<#
  Henter skærmbillederne til rumspillets lektion 04-boom-og-lyd ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-04-boom-og-lyd.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs04",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\04-boom-og-lyd\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "03-search-particle.png";    Name = "01-search-particle.png";    Mask = @() }
  @{ From = "04-particle-editor.png";    Name = "02-particle-presets.png";   Mask = @() }
  @{ From = "05-red-explosion-2d.png";   Name = "03-redexplosion-list.png";  Mask = @() }
  @{ From = "07-circle.png";             Name = "04-eksplosion-settings.png"; Mask = @() }
  @{ From = "14-create-explosion.png";   Name = "05-create-explosion.png";   Mask = @() }
  @{ From = "09-play-sound.png";         Name = "06-play-sound.png";         Mask = @() }
  @{ From = "11-sound-search.png";       Name = "07-sound-store.png";        Mask = @() }
  @{ From = "13-sound-settings.png";     Name = "08-sound-settings.png";     Mask = @() }
  @{ From = "15-laser-sounds.png";       Name = "09-laser-sounds.png";       Mask = @() }
  @{ From = "18-music.png";              Name = "10-music.png";              Mask = @() }
  @{ From = "20-text-z.png";             Name = "11-text-z.png";             Mask = @() }
  @{ From = "19-events-done.png";        Name = "12-events-done.png";        Mask = @() }
  @{ From = "pv2-4.png";                 Name = "13-preview.png";            Mask = @() }
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
