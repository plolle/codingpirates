<#
  Henter skærmbillederne til rumspillets lektion 02-skyd ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-02-skyd.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs02",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\02-skyd\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-lasers-folder.png";      Name = "01-lasers-folder.png";      Mask = @() }
  @{ From = "02-laser-asset.png";        Name = "02-laser-asset.png";        Mask = @() }
  @{ From = "03-laser-in-list.png";      Name = "03-laser-in-list.png";      Mask = @() }
  @{ From = "04-add-behavior.png";       Name = "04-add-behavior.png";       Mask = @() }
  @{ From = "05-destroy-behavior.png";   Name = "05-destroy-behavior.png";   Mask = @() }
  @{ From = "06-second-event.png";       Name = "06-new-event.png";          Mask = @() }
  @{ From = "09-beginning-selected.png"; Name = "07-beginning-condition.png"; Mask = @() }
  @{ From = "11-timer-name.png";         Name = "08-start-timer.png";        Mask = @() }
  @{ From = "12-start-event.png";        Name = "09-start-event.png";        Mask = @() }
  @{ From = "14-key-space.png";          Name = "10-key-space.png";          Mask = @() }
  @{ From = "15-timer-condition.png";    Name = "11-timer-condition.png";    Mask = @() }
  @{ From = "16-create-laser.png";       Name = "12-create-laser.png";       Mask = @() }
  @{ From = "18-force-900.png";          Name = "13-force.png";              Mask = @() }
  @{ From = "19-events-done.png";        Name = "14-events-done.png";        Mask = @() }
  @{ From = "pv-shooting.png";           Name = "15-preview.png";            Mask = @() }
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
