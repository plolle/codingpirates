<#
  Laver alle markeringer til rumspillets lektion 03-asteroider ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\03-asteroider\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("21-preview.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - asteroiden: Big Brown Meteor 1, Add to the scene, navnet, DestroyOutside
& $T -In "$O\01-meteors-folder.png"    -Out "$I\01-meteors-folder.png"    -Box "66,502,114,114,1"
& $T -In "$O\02-meteor-asset.png"      -Out "$I\02-meteor-asset.png"      -Box "1181,680,120,32,1"
& $T -In "$O\03-asteroide-in-list.png" -Out "$I\03-asteroide-in-list.png" -Box "1141,278,222,30,1"
& $T -In "$O\04-asteroide-destroy.png" -Out "$I\04-asteroide-destroy.png" -Box "10,340,290,122,1"

# Opgave 2 - tekst til point: fanen, Text, indstillingerne, hvid farve, placeringen
& $T -In "$O\05-from-scratch.png"      -Out "$I\05-from-scratch.png"      -Box "683,95,616,30,1"
& $T -In "$O\06-search-text.png"       -Out "$I\06-search-text.png"       -Box "230,140,1040,32,1","66,196,600,50,2"
& $T -In "$O\07-text-settings.png"     -Out "$I\07-text-settings.png"     -Box "67,132,1222,48,1","62,188,308,32,2","67,284,1222,180,3","1234,680,68,32,4"
& $T -In "$O\08-color-white.png"       -Out "$I\08-color-white.png"       -Box "399,448,22,22,1"
& $T -In "$O\09-text-placed.png"       -Out "$I\09-text-placed.png"       -Box "370,234,94,30,1","8,184,300,28,2"

# Opgave 3 - scenevariablen Point
& $T -In "$O\10-scene-variable.png"    -Out "$I\10-scene-variable.png"    -Box "282,256,24,24,1","4,329,308,26,2"

# Opgave 4 - en timer mere, og eventet der laver asteroider
& $T -In "$O\11-second-timer.png"      -Out "$I\11-second-timer.png"      -Box "576,149,300,20,1"
& $T -In "$O\12-create-asteroide.png"  -Out "$I\12-create-asteroide.png"  -Box "72,268,396,32,1","478,136,410,32,2","906,180,313,112,3"
& $T -In "$O\13-asteroide-force.png"   -Out "$I\13-asteroide-force.png"   -Box "906,160,313,112,1","912,435,88,30,2"
& $T -In "$O\14-asteroide-event.png"   -Out "$I\14-asteroide-event.png"   -Box "34,285,1322,126,1"

# Opgave 5 - kollision, slet, point
& $T -In "$O\15-collision.png"         -Out "$I\15-collision.png"         -Box "72,236,396,32,1","478,136,410,48,2","906,160,396,48,3"
& $T -In "$O\16-delete-laser.png"      -Out "$I\16-delete-laser.png"      -Box "478,136,410,48,1"
& $T -In "$O\17-add-points.png"        -Out "$I\17-add-points.png"        -Box "493,150,750,48,1","493,207,810,48,2","493,263,726,50,3"

# Opgave 6 - drej asteroiderne, og vis pointene
& $T -In "$O\18-rotate.png"            -Out "$I\18-rotate.png"            -Box "478,199,400,32,1","906,180,313,52,2"
& $T -In "$O\19-text-action.png"       -Out "$I\19-text-action.png"       -Box "478,136,410,32,1","906,263,300,50,2"

# Hele koden samlet - event 1 med de to nye handlinger
& $T -In "$O\20-events-done.png"       -Out "$I\20-events-done.png"       -Box "576,101,420,42,1"

""
"Faerdig. Alle markeringer for rumspil 03-asteroider er lavet forfra."
