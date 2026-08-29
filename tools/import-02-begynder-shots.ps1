<#
  Henter de nye skærmbilleder ind i lektion 02-begynder.
  Se import-01-intro-shots.ps1 for detaljer - samme fremgangsmåde.

  Maskerne er tekststrenge "x,y,bredde,hoejde". Brug ikke tal-arrays:
  PowerShell pakker et enkelt tal-array ud, og maskeringen forsvinder stiltiende.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Src,
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\02-begynder\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

$map = @(
  @{ Id = "-27"; Name = "01-object-editor.png";       Mask = @() }
  @{ Id = "-28"; Name = "02-collision-auto.png";      Mask = @() }
  @{ Id = "-29"; Name = "03-collision-custom.png";    Mask = @() }
  @{ Id = "-30"; Name = "04-behaviors-empty.png";     Mask = @() }
  @{ Id = "-31"; Name = "05-behavior-list.png";       Mask = @() }
  @{ Id = "-32"; Name = "06-platformer-character.png";Mask = @() }
  @{ Id = "-33"; Name = "07-platform-behavior.png";   Mask = @() }
  @{ Id = "-34"; Name = "08-jumpthru.png";            Mask = @() }
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
    $bg = $bmp.GetPixel([Math]::Max(0, $x - 14), $y + [int]($h / 2))
    $brush = New-Object System.Drawing.SolidBrush $bg
    $g.FillRectangle($brush, $x, $y, $w, $h)
    $brush.Dispose(); $masked++
  }

  $g.Dispose(); $img.Dispose()
  $bmp.Save((Join-Path $dest $m.Name), [System.Drawing.Imaging.ImageFormat]::Png)
  "{0,-30} <- {1}  ({2} x {3}){4}" -f $m.Name, $file.Name, $bmp.Width, $bmp.Height, $(if ($masked) { "  [$masked maskeret]" } else { "" })
  $bmp.Dispose()
}
