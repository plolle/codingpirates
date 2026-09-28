<#
  Henter skærmbillederne til rumspillets lektion 06-fjender ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-06-fjender.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs06",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\06-fjender\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-enemies-folder.png";      Name = "01-enemies-folder.png";     Mask = @() }
  @{ From = "03-fjende-in-list.png";      Name = "02-fjende-in-list.png";     Mask = @() }
  @{ From = "06-red-lasers.png";          Name = "03-red-lasers.png";         Mask = @() }
  @{ From = "07-fjendelaser.png";         Name = "04-fjendelaser.png";        Mask = @() }
  @{ From = "08-groups-panel.png";        Name = "05-groups-panel.png";       Mask = @() }
  @{ From = "10-group-dialog.png";        Name = "06-group-dialog.png";       Mask = @() }
  @{ From = "13-cond-fjender.png";        Name = "07-cond-fjender.png";       Mask = @() }
  @{ From = "look-after-expl.png";        Name = "08-events-group.png";       Mask = @() }
  @{ From = "15-create-fjende.png";       Name = "09-create-fjende.png";      Mask = @() }
  @{ From = "16-object-timer.png";        Name = "10-object-timer.png";       Mask = @() }
  @{ From = "17-flip.png";                Name = "11-flip.png";               Mask = @() }
  @{ From = "18-wave-force.png";          Name = "12-wave-force.png";         Mask = @() }
  @{ From = "19-objtimer-cond.png";       Name = "13-objtimer-cond.png";      Mask = @() }
  @{ From = "20-create-fjendelaser.png";  Name = "14-create-fjendelaser.png"; Mask = @() }
  @{ From = "21-laser-hits-ship.png";     Name = "15-laser-hits-ship.png";    Mask = @() }
  @{ From = "22-events-top.png";          Name = "16-events-top.png";         Mask = @() }
  @{ From = "look-ev9-10.png";            Name = "17-events-bottom.png";      Mask = @() }
  @{ From = "pv-13.png";                  Name = "18-preview.png";            Mask = @() }
  @{ From = "pvn-10.png";                 Name = "19-preview-enemy-laser.png"; Mask = @() }
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
