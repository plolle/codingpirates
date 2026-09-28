<#
  Henter skærmbillederne til rumspillets lektion 01-intro ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - maskerer e-mailadressen i den øverste bjælke, så den ikke bliver offentliggjort
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-rumspil-01-intro.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\rs01",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\rumspil\01-intro\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-new-game-dialog.png";  Name = "01-new-game-dialog.png";  Mask = @() }
  @{ From = "02-project-setup.png";    Name = "02-project-setup.png";    Mask = @("974,42,140,32") }
  @{ From = "03-editor.png";           Name = "03-editor.png";           Mask = @() }
  @{ From = "04-new-object.png";       Name = "04-new-object.png";       Mask = @() }
  @{ From = "05-asset-search.png";     Name = "05-asset-search.png";     Mask = @() }
  @{ From = "06-asset-pack.png";       Name = "06-asset-pack.png";       Mask = @() }
  @{ From = "07-ship-folder.png";      Name = "07-ship-folder.png";      Mask = @() }
  @{ From = "08-ship-asset.png";       Name = "08-ship-asset.png";       Mask = @() }
  @{ From = "09-background-folder.png"; Name = "09-background-folder.png"; Mask = @() }
  @{ From = "10-objects-added.png";    Name = "10-objects-added.png";    Mask = @() }
  @{ From = "11-rename-menu.png";      Name = "11-rename-menu.png";      Mask = @() }
  @{ From = "look-drag2.png";          Name = "12-background-placed.png"; Mask = @() }
  @{ From = "14-background-size.png";  Name = "13-background-size.png";  Mask = @() }
  @{ From = "15-ship-placed.png";      Name = "14-ship-placed.png";      Mask = @() }
  @{ From = "16-ship-object.png";      Name = "15-ship-object.png";      Mask = @() }
  @{ From = "17-add-behavior.png";     Name = "16-add-behavior.png";     Mask = @() }
  @{ From = "18-topdown-settings.png"; Name = "17-topdown-settings.png"; Mask = @() }
  @{ From = "19-search-screen.png";    Name = "18-search-screen.png";    Mask = @() }
  @{ From = "20-stay-on-screen.png";   Name = "19-stay-on-screen.png";   Mask = @() }
  @{ From = "21-events-empty.png";     Name = "20-events-empty.png";     Mask = @() }
  @{ From = "22-new-event.png";        Name = "21-new-event.png";        Mask = @() }
  @{ From = "23-action-picker.png";    Name = "22-action-picker.png";    Mask = @() }
  @{ From = "25-search-offset.png";    Name = "23-search-offset.png";    Mask = @() }
  @{ From = "27-offset-add-2.png";     Name = "24-offset-add-2.png";     Mask = @() }
  @{ From = "28-event-done.png";       Name = "25-event-done.png";       Mask = @() }
  @{ From = "pv-1.png";                Name = "26-preview.png";          Mask = @() }
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
