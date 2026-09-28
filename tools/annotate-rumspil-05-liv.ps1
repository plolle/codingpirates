<#
  Laver alle markeringer til rumspillets lektion 05-liv ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\05-liv\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("15-preview-hit.png", "16-preview-gameover.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - health bar: soeg, Health Bar Fill, placering og stoerrelse
& $T -In "$O\01-search-healthbar.png"  -Out "$I\01-search-healthbar.png"  -Box "178,140,1084,32,1","374,187,146,146,2"
& $T -In "$O\02-healthbar-fill.png"    -Out "$I\02-healthbar-fill.png"    -Box "410,228,420,26,1","1181,680,120,32,2"
& $T -In "$O\03-healthbar-placed.png"  -Out "$I\03-healthbar-placed.png"  -Box "8,184,300,28,1","8,248,300,60,2","870,226,192,34,3"

# Opgave 2 - variablen Liv
& $T -In "$O\04-liv-variable.png"      -Out "$I\04-liv-variable.png"      -Box "4,359,308,26,1"

# Opgave 3 - baren foelger Liv
& $T -In "$O\05-bar-width.png"         -Out "$I\05-bar-width.png"         -Box "72,332,396,32,1","478,136,410,48,2","906,263,313,50,3"

# Opgave 4 - skibet rammes: kollision, Liv - 1, dybt brag
& $T -In "$O\06-skib-collision.png"    -Out "$I\06-skib-collision.png"    -Box "72,204,396,32,1","478,136,410,48,2","906,160,396,48,3"
& $T -In "$O\07-liv-minus.png"         -Out "$I\07-liv-minus.png"         -Box "493,150,750,48,1","493,207,810,48,2","493,263,726,50,3"
& $T -In "$O\08-hit-sound.png"         -Out "$I\08-hit-sound.png"         -Box "493,262,726,52,1","493,345,726,52,2"

# Opgave 5 - GAME OVER: teksten, Liv <= 0, Trigger once, Z order
& $T -In "$O\09-gameover-text.png"     -Out "$I\09-gameover-text.png"     -Box "67,132,1222,48,1","62,188,308,32,2","67,284,1222,180,3"
& $T -In "$O\10-liv-zero.png"          -Out "$I\10-liv-zero.png"          -Box "72,160,386,44,1","493,150,750,48,2","493,207,810,48,3","493,263,726,50,4"
& $T -In "$O\11-trigger-once.png"      -Out "$I\11-trigger-once.png"      -Box "72,160,396,44,1"
& $T -In "$O\12-z-order.png"           -Out "$I\12-z-order.png"           -Box "72,428,396,32,1","478,136,410,48,2","906,206,313,50,3"

# Opgave 6 - intet skud uden skib
& $T -In "$O\13-liv-above-zero.png"    -Out "$I\13-liv-above-zero.png"    -Box "493,207,810,48,1","493,263,726,50,2"

# Hele koden samlet - de to nye events og den nye condition
& $T -In "$O\14-events-done.png"       -Out "$I\14-events-done.png"       -Box "40,218,220,20,1","40,509,264,20,2","40,620,160,42,3"

""
"Faerdig. Alle markeringer for rumspil 05-liv er lavet forfra."
