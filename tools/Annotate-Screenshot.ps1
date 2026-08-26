<#
.SYNOPSIS
  Tegner farvede markeringer på et skærmbillede, så børnene kan se hvor de skal klikke.

.DESCRIPTION
  Lægger en eller flere markeringsbokse på et PNG. Hver boks kan få et nummer,
  så man kan henvise til "1", "2", "3" i teksten. Med -Dim dæmpes resten af
  billedet, så markeringen står helt skarpt.

.PARAMETER Box
  En eller flere bokse som "x,y,bredde,højde" eller "x,y,bredde,højde,nummer".
  Koordinater i pixels, målt fra øverste venstre hjørne.

.EXAMPLE
  .\Annotate-Screenshot.ps1 -In raw.png -Out ude.png -Box "968,780,225,40,1" -Dim

.EXAMPLE
  .\Annotate-Screenshot.ps1 -In raw.png -Out ude.png -Box "10,10,200,50,1","10,80,200,50,2"
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$In,
  [Parameter(Mandatory)][string]$Out,
  [Parameter(Mandatory)][string[]]$Box,
  [string]$Color = "#FFC400",
  [switch]$Dim,
  [int]$DimPercent = 60,
  [double]$StrokeScale = 1.0
)

Add-Type -AssemblyName System.Drawing

if (-not (Test-Path $In)) { throw "Kan ikke finde inputfilen: $In" }

$src = [System.Drawing.Image]::FromFile((Resolve-Path $In).Path)
$bmp = New-Object System.Drawing.Bitmap $src.Width, $src.Height
$g   = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$g.DrawImage($src, 0, 0, $src.Width, $src.Height)

# Parse boxes up front so a typo fails before we write anything
$rects = @()
foreach ($b in $Box) {
  $p = $b -split '\s*,\s*'
  if ($p.Count -lt 4) { throw "Boks '$b' skal have mindst x,y,bredde,hoejde" }
  $rects += [pscustomobject]@{
    X = [int]$p[0]; Y = [int]$p[1]; W = [int]$p[2]; H = [int]$p[3]
    Label = if ($p.Count -ge 5 -and $p[4] -ne '') { $p[4] } else { $null }
  }
}

# Dim everything except the highlighted regions
if ($Dim) {
  $alpha = [int](255 * ($DimPercent / 100.0))
  $shade = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb($alpha, 0, 0, 0))
  $g.FillRectangle($shade, 0, 0, $bmp.Width, $bmp.Height)
  $shade.Dispose()
  # Punch the original pixels back in over each box
  foreach ($r in $rects) {
    $dest = New-Object System.Drawing.Rectangle $r.X, $r.Y, $r.W, $r.H
    $g.DrawImage($src, $dest, $r.X, $r.Y, $r.W, $r.H, [System.Drawing.GraphicsUnit]::Pixel)
  }
}

$accent = [System.Drawing.ColorTranslator]::FromHtml($Color)
$stroke = [Math]::Max(3, [int]([Math]::Round($bmp.Width / 320.0 * $StrokeScale)))

foreach ($r in $rects) {
  # Dark halo underneath so the marker stays visible on light backgrounds too
  $halo = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(140, 0, 0, 0)), ($stroke + 3)
  $g.DrawRectangle($halo, $r.X - 1, $r.Y - 1, $r.W + 2, $r.H + 2)
  $halo.Dispose()

  $pen = New-Object System.Drawing.Pen $accent, $stroke
  $g.DrawRectangle($pen, $r.X, $r.Y, $r.W, $r.H)
  $pen.Dispose()

  if ($r.Label) {
    $d   = [Math]::Max(26, [int]($bmp.Width / 26))
    $gap = [int]($stroke * 1.5) + 2
    # Sit the badge fully OUTSIDE the box so it never covers the thing we point at.
    # Prefer left; then right; then above; then below.
    $cy = $r.Y + [int](($r.H - $d) / 2)
    if (($r.X - $d - $gap) -ge 2) {
      $cx = $r.X - $d - $gap
    } elseif (($r.X + $r.W + $gap + $d) -le ($bmp.Width - 2)) {
      $cx = $r.X + $r.W + $gap
    } else {
      $cx = $r.X
      if (($r.Y - $d - $gap) -ge 2) { $cy = $r.Y - $d - $gap } else { $cy = $r.Y + $r.H + $gap }
    }
    $cx = [Math]::Min([Math]::Max($cx, 2), $bmp.Width  - $d - 2)
    $cy = [Math]::Min([Math]::Max($cy, 2), $bmp.Height - $d - 2)

    $badgeShadow = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(150, 0, 0, 0))
    $g.FillEllipse($badgeShadow, $cx + 2, $cy + 2, $d, $d)
    $badgeShadow.Dispose()

    $badge = New-Object System.Drawing.SolidBrush $accent
    $g.FillEllipse($badge, $cx, $cy, $d, $d)
    $badge.Dispose()

    $font = New-Object System.Drawing.Font "Segoe UI", ([single]($d * 0.55)), ([System.Drawing.FontStyle]::Bold), ([System.Drawing.GraphicsUnit]::Pixel)
    $fmt  = New-Object System.Drawing.StringFormat
    $fmt.Alignment     = [System.Drawing.StringAlignment]::Center
    $fmt.LineAlignment = [System.Drawing.StringAlignment]::Center
    $textBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 20, 20, 20))
    $layout = New-Object System.Drawing.RectangleF $cx, $cy, $d, $d
    $g.DrawString($r.Label, $font, $textBrush, $layout, $fmt)
    $textBrush.Dispose(); $font.Dispose(); $fmt.Dispose()
  }
}

$outDir = Split-Path -Parent $Out
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

$bmp.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose(); $src.Dispose()

"OK  $Out  ($($rects.Count) markering(er))"
