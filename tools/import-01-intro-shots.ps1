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

# kilde-suffiks -> nyt filnavn, plus omraade der skal maskeres (x,y,b,h) eller $null
$map = @(
  @{ Id = "-25"; Name = "01-create-page.png";     Mask = @(1128, 43, 150, 28) }
  @{ Id = "-26"; Name = "02-new-game-dialog.png"; Mask = @(1255, 44, 60, 28) }
  # to maskeringer: e-mail i toppen, og navnet paa et andet projekt nederst
  @{ Id = "-12"; Name = "03-project-setup.png";   Mask = @(1178, 45, 140, 28), @(528, 688, 320, 60) }
  @{ Id = "-13"; Name = "04-editor.png";          Mask = $null }
  @{ Id = "-14"; Name = "05-new-object.png";      Mask = $null }
  @{ Id = "-16"; Name = "06-asset-search.png";    Mask = $null }
  @{ Id = "-17"; Name = "07-asset-pack.png";      Mask = $null }
  @{ Id = "-19"; Name = "08-add-confirm.png";     Mask = $null }
  @{ Id = "-21"; Name = "09-objects-list.png";    Mask = $null }
  @{ Id = "-23"; Name = "10-project-manager.png"; Mask = $null }
  @{ Id = "-24"; Name = "11-file-menu.png";       Mask = $null }
)

foreach ($m in $map) {
  $file = Get-ChildItem $Src -Filter "*$($m.Id).jpg" | Select-Object -First 1
  if (-not $file) { Write-Warning "Fandt ikke kilde for $($m.Name) (id $($m.Id))"; continue }

  $img = [System.Drawing.Image]::FromFile($file.FullName)
  $bmp = New-Object System.Drawing.Bitmap $img.Width, $img.Height
  $g   = [System.Drawing.Graphics]::FromImage($bmp)
  $g.DrawImage($img, 0, 0, $img.Width, $img.Height)

  if ($m.Mask) {
    # Én maskering er en flad liste paa 4 tal; flere er en liste af saadanne
    $rects = if ($m.Mask[0] -is [array]) { $m.Mask } else { ,$m.Mask }
    foreach ($r in $rects) {
      $x, $y, $w, $h = $r
      # Tag baggrundsfarven lige til venstre for feltet, saa maskeringen falder i et
      $bg = $bmp.GetPixel([Math]::Max(0, $x - 12), $y + [int]($h / 2))
      $brush = New-Object System.Drawing.SolidBrush $bg
      $g.FillRectangle($brush, $x, $y, $w, $h)
      $brush.Dispose()
    }
  }

  $g.Dispose(); $img.Dispose()
  $out = Join-Path $dest $m.Name
  $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
  "{0,-26} <- {1}  ({2} x {3}){4}" -f $m.Name, $file.Name, $bmp.Width, $bmp.Height, $(if ($m.Mask) { "  [e-mail maskeret]" } else { "" })
  $bmp.Dispose()
}
