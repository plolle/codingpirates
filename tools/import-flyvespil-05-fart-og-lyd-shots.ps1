<#
  Henter skærmbillederne til flyvespillets lektion 05-fart-og-lyd ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - maskerer e-mailadressen i den øverste bjælke, så den ikke bliver offentliggjort
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-flyvespil-05-fart-og-lyd.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\fs05",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\flyvespil\05-fart-og-lyd\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-fart-variable.png"; Name = "01-fart-variable.png"; Mask = @() }
  @{ From = "02-force-fart.png"; Name = "02-force-fart.png"; Mask = @() }
  @{ From = "03-offset-fart.png"; Name = "03-offset-fart.png"; Mask = @() }
  @{ From = "04-start-fart-timer.png"; Name = "04-start-fart-timer.png"; Mask = @() }
  @{ From = "05-event8.png"; Name = "05-event8.png"; Mask = @() }
  @{ From = "06-fart-timer-cond.png"; Name = "06-fart-timer-cond.png"; Mask = @() }
  @{ From = "07-fart-less-400.png"; Name = "07-fart-less-400.png"; Mask = @() }
  @{ From = "08-fart-add-20.png"; Name = "08-fart-add-20.png"; Mask = @() }
  @{ From = "09-fart-event.png"; Name = "09-fart-event.png"; Mask = @() }
  @{ From = "10-play-sound.png"; Name = "10-play-sound.png"; Mask = @() }
  @{ From = "11-jump-sound.png"; Name = "11-jump-sound.png"; Mask = @() }
  @{ From = "12-jump-settings.png"; Name = "12-jump-settings.png"; Mask = @() }
  @{ From = "13-hit-sound.png"; Name = "13-hit-sound.png"; Mask = @() }
  @{ From = "14-coin-sound.png"; Name = "14-coin-sound.png"; Mask = @() }
  @{ From = "15-all-events.png"; Name = "15-all-events.png"; Mask = @() }
  @{ From = "pv-2.png"; Name = "16-preview.png"; Mask = @() }
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
