<#
  Henter de nye skærmbilleder ind i lektion 05-middel-fjender.
  Masker angives som tekststrenge "x,y,bredde,hoejde" - se import-01-intro-shots.ps1.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Src,
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\05-middel-fjender\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

$map = @(
  @{ Id = "-63"; Name = "01-arrow-search.png";     Mask = @() }
  @{ Id = "-64"; Name = "02-add-arrow.png";        Mask = @() }
  @{ Id = "-65"; Name = "03-object-variables.png"; Mask = @() }
  @{ Id = "-66"; Name = "04-boolean-variable.png"; Mask = @() }
  @{ Id = "-68"; Name = "05-boolean-condition.png";Mask = @() }
  @{ Id = "-69"; Name = "06-add-force.png";        Mask = @() }
  @{ Id = "-70"; Name = "07-force-values.png";     Mask = @() }
  @{ Id = "-71"; Name = "08-set-boolean.png";      Mask = @() }
  @{ Id = "-72"; Name = "09-finished-events.png";  Mask = @() }
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
