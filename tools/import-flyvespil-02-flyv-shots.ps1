<#
  Henter skærmbillederne til flyvespillets lektion 02-flyv ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - maskerer e-mailadressen i den øverste bjælke, så den ikke bliver offentliggjort
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-flyvespil-02-flyv.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\fs02",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\flyvespil\02-flyv\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ From = "01-fugl-object.png";          Name = "01-fugl-object.png";          Mask = @() }
  @{ From = "02-add-behavior.png";         Name = "02-add-behavior.png";         Mask = @() }
  @{ From = "03-platformer-settings.png";  Name = "03-platformer-settings.png";  Mask = @() }
  @{ From = "04-new-event.png";            Name = "04-new-event.png";            Mask = @() }
  @{ From = "05-search-key.png";           Name = "05-search-key.png";           Mask = @() }
  @{ From = "06-key-space.png";            Name = "06-key-space.png";            Mask = @() }
  @{ From = "07-search-jump.png";          Name = "07-search-jump.png";          Mask = @() }
  @{ From = "08-simulate-jump.png";        Name = "08-simulate-jump.png";        Mask = @() }
  @{ From = "09-flap-event.png";           Name = "09-flap-event.png";           Mask = @() }
  @{ From = "11-mouse-left.png";           Name = "10-mouse-left.png";           Mask = @() }
  @{ From = "12-trigger-once.png";         Name = "11-trigger-once.png";         Mask = @() }
  @{ From = "13-mouse-event.png";          Name = "12-mouse-event.png";          Mask = @() }
  @{ From = "14-is-jumping.png";           Name = "13-is-jumping.png";           Mask = @() }
  @{ From = "15-angle-minus20.png";        Name = "14-angle-minus20.png";        Mask = @() }
  @{ From = "16-rotate-toward.png";        Name = "15-rotate-toward.png";        Mask = @() }
  @{ From = "17-y-less-0.png";             Name = "16-y-less-0.png";             Mask = @() }
  @{ From = "18-set-y-0.png";              Name = "17-set-y-0.png";              Mask = @() }
  @{ From = "19-all-events.png";           Name = "18-all-events.png";           Mask = @() }
  @{ From = "pv-1.png";                    Name = "19-preview-flap.png";         Mask = @() }
  @{ From = "pv-2.png";                    Name = "20-preview-fall.png";         Mask = @() }
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
