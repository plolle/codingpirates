<#
  Henter de nye skærmbilleder ind i lektion 04-middel-variabler.
  Masker angives som tekststrenge "x,y,bredde,hoejde" - se import-01-intro-shots.ps1.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Src,
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\04-middel-variabler\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

$map = @(
  @{ Id = "-45"; Name = "01-new-object-scratch.png"; Mask = @() }
  @{ Id = "-46"; Name = "02-text-object.png";        Mask = @() }
  @{ Id = "-48"; Name = "03-edit-text.png";          Mask = @() }
  @{ Id = "-51"; Name = "04-global-variables.png";   Mask = @() }
  @{ Id = "-53"; Name = "05-add-variable.png";       Mask = @() }
  @{ Id = "-55"; Name = "06-name-warning.png";       Mask = @() }
  @{ Id = "-54"; Name = "07-change-variable.png";    Mask = @() }
  @{ Id = "-58"; Name = "08-collision.png";          Mask = @() }
  @{ Id = "-59"; Name = "09-add-one.png";            Mask = @() }
  @{ Id = "-60"; Name = "10-text-expression.png";    Mask = @() }
  @{ Id = "-61"; Name = "11-finished-events.png";    Mask = @() }
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
    $x=[int]$p[0]; $y=[int]$p[1]; $w=[int]$p[2]; $h=[int]$p[3]
    $bg = $bmp.GetPixel([Math]::Max(0,$x-14), $y+[int]($h/2))
    $brush = New-Object System.Drawing.SolidBrush $bg
    $g.FillRectangle($brush, $x, $y, $w, $h); $brush.Dispose(); $masked++
  }
  $g.Dispose(); $img.Dispose()
  $bmp.Save((Join-Path $dest $m.Name), [System.Drawing.Imaging.ImageFormat]::Png)
  "{0,-28} <- {1}  ({2} x {3}){4}" -f $m.Name, $file.Name, $bmp.Width, $bmp.Height, $(if($masked){"  [$masked maskeret]"}else{""})
  $bmp.Dispose()
}
