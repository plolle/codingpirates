<#
  Henter skærmbillederne til flyvespillets lektion 04-point-game-over ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - maskerer e-mailadressen i den øverste bjælke, så den ikke bliver offentliggjort
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-flyvespil-04-point-game-over.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\fs04",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\flyvespil\04-point-game-over\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-scene-props.png"; Name = "01-scene-variables-plus.png"; Mask = @() }
  @{ From = "02-scene-variables.png"; Name = "02-scene-variables.png"; Mask = @() }
  @{ From = "03-object-variable.png"; Name = "03-object-variable.png"; Mask = @() }
  @{ From = "04-from-scratch.png"; Name = "04-from-scratch.png"; Mask = @() }
  @{ From = "05-search-text.png"; Name = "05-search-text.png"; Mask = @() }
  @{ From = "06-text-settings.png"; Name = "06-text-settings.png"; Mask = @() }
  @{ From = "07-gameover-text.png"; Name = "07-gameover-text.png"; Mask = @() }
  @{ From = "29-gui-layer.png"; Name = "08-gui-layer.png"; Mask = @() }
  @{ From = "30-pointtekst-gui.png"; Name = "09-pointtekst-gui.png"; Mask = @() }
  @{ From = "10-gameover-false.png"; Name = "10-gameover-false.png"; Mask = @() }
  @{ From = "11-event1-condition.png"; Name = "11-event1-condition.png"; Mask = @() }
  @{ From = "12-set-gameover-true.png"; Name = "12-set-gameover-true.png"; Mask = @() }
  @{ From = "13-event7-changed.png"; Name = "13-event7-changed.png"; Mask = @() }
  @{ From = "14-collision.png"; Name = "14-collision.png"; Mask = @() }
  @{ From = "15-gameover-true.png"; Name = "15-gameover-true.png"; Mask = @() }
  @{ From = "16-animation-hit.png"; Name = "16-animation-hit.png"; Mask = @() }
  @{ From = "17-time-scale.png"; Name = "17-time-scale.png"; Mask = @() }
  @{ From = "18-create-gameovertekst.png"; Name = "18-create-gameovertekst.png"; Mask = @() }
  @{ From = "20-x-less-150.png"; Name = "19-x-less-150.png"; Mask = @() }
  @{ From = "21-y-greater-0.png"; Name = "20-y-greater-0.png"; Mask = @() }
  @{ From = "22-talt-false.png"; Name = "21-talt-false.png"; Mask = @() }
  @{ From = "23-set-talt.png"; Name = "22-set-talt.png"; Mask = @() }
  @{ From = "24-point-add-1.png"; Name = "23-point-add-1.png"; Mask = @() }
  @{ From = "25-text-action.png"; Name = "24-text-action.png"; Mask = @() }
  @{ From = "26-change-scene.png"; Name = "25-change-scene.png"; Mask = @() }
  @{ From = "27-mouse-released.png"; Name = "26-mouse-released.png"; Mask = @() }
  @{ From = "31-all-events-end.png"; Name = "27-all-events.png"; Mask = @() }
  @{ From = "pv-1.png"; Name = "28-preview.png"; Mask = @() }
  @{ From = "pv-2.png"; Name = "29-preview-gameover.png"; Mask = @() }
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
