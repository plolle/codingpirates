<#
  Henter de nye skærmbilleder ind i lektion 01-intro.

  - konverterer fra JPG til PNG
  - maskerer e-mailadressen i den øverste bjælke, så den ikke bliver offentliggjort
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-01-intro.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Src,
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\01-intro\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kilde-suffiks -> nyt filnavn, plus de omraader der skal maskeres.
# Maskerne er tekststrenge "x,y,bredde,hoejde" - IKKE tal-arrays. PowerShell
# pakker et enkelt tal-array ud, saa en enkelt maske ellers stiltiende forsvinder.
$map = @(
  @{ Id = "-25"; Name = "01-create-page.png";     Mask = @("1112,44,190,44") }
  @{ Id = "-26"; Name = "02-new-game-dialog.png"; Mask = @("1236,44,92,44") }
  # e-mail i toppen, og navnet paa et andet projekt nederst
  @{ Id = "-12"; Name = "03-project-setup.png";   Mask = @("1172,44,152,44", "528,688,320,60") }
  @{ Id = "-13"; Name = "04-editor.png";          Mask = @() }
  @{ Id = "-14"; Name = "05-new-object.png";      Mask = @() }
  @{ Id = "-16"; Name = "06-asset-search.png";    Mask = @() }
  @{ Id = "-17"; Name = "07-asset-pack.png";      Mask = @() }
  @{ Id = "-19"; Name = "08-add-confirm.png";     Mask = @() }
  @{ Id = "-21"; Name = "09-objects-list.png";    Mask = @() }
  @{ Id = "-23"; Name = "10-project-manager.png"; Mask = @() }
  @{ Id = "-24"; Name = "11-file-menu.png";       Mask = @() }
)

foreach ($m in $map) {
  $file = Get-ChildItem $Src -Filter "*$($m.Id).jpg" | Select-Object -First 1
  if (-not $file) { Write-Warning "Fandt ikke kilde for $($m.Name) (id $($m.Id))"; continue }

  $img = [System.Drawing.Image]::FromFile($file.FullName)
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
  "{0,-26} <- {1}  ({2} x {3}){4}" -f $m.Name, $file.Name, $bmp.Width, $bmp.Height, $(if ($masked) { "  [$masked omraade(r) maskeret]" } else { "" })
  $bmp.Dispose()
}
