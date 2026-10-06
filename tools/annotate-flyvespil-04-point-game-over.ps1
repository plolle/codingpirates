<#
  Laver alle markeringer til flyvespillets lektion 04-point-game-over ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\flyvespil\04-point-game-over\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("27-all-events.png", "28-preview.png", "29-preview-gameover.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - variabler: + ved Scene Variables, Point og GameOver, og Talt paa Stolpe
& $T -In "$O\01-scene-variables-plus.png" -Out "$I\01-scene-variables-plus.png" -Box "281,256,24,24,1"
& $T -In "$O\02-scene-variables.png"  -Out "$I\02-scene-variables.png"  -Box "4,330,308,58,1"
& $T -In "$O\03-object-variable.png"  -Out "$I\03-object-variable.png"  -Box "1141,247,222,30,1","270,590,26,26,2","4,664,298,28,3"

# Opgave 2 - tekst: New object from scratch, Text, og indstillingerne
& $T -In "$O\04-from-scratch.png"     -Out "$I\04-from-scratch.png"     -Box "683,96,616,28,1"
& $T -In "$O\05-search-text.png"      -Out "$I\05-search-text.png"      -Box "230,140,1040,32,1","66,194,560,50,2"
& $T -In "$O\06-text-settings.png"    -Out "$I\06-text-settings.png"    -Box "67,132,1222,48,1","60,190,320,28,2","67,284,1222,180,3","62,505,100,26,4"
& $T -In "$O\07-gameover-text.png"    -Out "$I\07-gameover-text.png"    -Box "67,132,1222,48,1","60,190,510,28,2","67,284,1222,180,3"

# Opgave 3 - laget GUI, og PointTekst paa scenen
& $T -In "$O\08-gui-layer.png"        -Out "$I\08-gui-layer.png"        -Box "1328,456,26,26,1","1133,489,224,26,2"
& $T -In "$O\09-pointtekst-gui.png"   -Out "$I\09-pointtekst-gui.png"   -Box "370,227,102,48,1","8,184,300,28,2","8,345,300,26,3"

# Opgave 4 - event 1 og event 7
& $T -In "$O\10-gameover-false.png"   -Out "$I\10-gameover-false.png"   -Box "493,150,750,48,1","1255,216,48,28,2"
& $T -In "$O\11-event1-condition.png" -Out "$I\11-event1-condition.png" -Box "34,80,540,22,1"
& $T -In "$O\12-set-gameover-true.png" -Out "$I\12-set-gameover-true.png" -Box "493,174,750,48,1","493,230,810,48,2"
& $T -In "$O\13-event7-changed.png"   -Out "$I\13-event7-changed.png"   -Box "576,404,300,22,1"

# Opgave 5 - kollision
& $T -In "$O\14-collision.png"        -Out "$I\14-collision.png"        -Box "72,204,396,32,1","478,136,410,50,2","906,160,398,48,3"

# Opgave 6 - Game Over
& $T -In "$O\15-gameover-true.png"    -Out "$I\15-gameover-true.png"    -Box "493,150,750,48,1","1209,216,46,28,2"
& $T -In "$O\16-animation-hit.png"    -Out "$I\16-animation-hit.png"    -Box "478,336,410,50,1","906,296,230,48,2"
& $T -In "$O\17-time-scale.png"       -Out "$I\17-time-scale.png"       -Box "72,160,386,44,1","493,174,727,52,2"
& $T -In "$O\18-create-gameovertekst.png" -Out "$I\18-create-gameovertekst.png" -Box "493,160,810,48,1","493,216,727,111,2","493,334,642,50,3"

# Opgave 7 - point
& $T -In "$O\19-x-less-150.png"       -Out "$I\19-x-less-150.png"       -Box "478,136,400,50,1","906,150,398,50,2","906,206,314,52,3"
& $T -In "$O\20-y-greater-0.png"      -Out "$I\20-y-greater-0.png"      -Box "478,136,400,50,1","906,150,398,50,2","906,206,314,52,3"
& $T -In "$O\21-talt-false.png"       -Out "$I\21-talt-false.png"       -Box "478,136,410,50,1","906,150,338,48,2","1255,216,48,28,3"
& $T -In "$O\22-set-talt.png"         -Out "$I\22-set-talt.png"         -Box "478,136,410,50,1","906,174,338,48,2","906,230,398,48,3"
& $T -In "$O\23-point-add-1.png"      -Out "$I\23-point-add-1.png"      -Box "493,150,750,48,1","493,206,810,48,2","493,262,727,52,3"
& $T -In "$O\24-text-action.png"      -Out "$I\24-text-action.png"      -Box "72,268,396,32,1","478,136,410,32,2","906,262,300,52,3"

# Opgave 8 - proev igen
& $T -In "$O\25-change-scene.png"     -Out "$I\25-change-scene.png"     -Box "72,160,386,44,1","493,174,642,48,2"
& $T -In "$O\26-mouse-released.png"   -Out "$I\26-mouse-released.png"   -Box "72,160,386,44,1","493,150,642,48,2"

""
"Faerdig. Alle markeringer for flyvespil 04-point-game-over er lavet forfra."