<#
  Laver alle markeringer til flyvespillets lektion 02-flyv ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\flyvespil\02-flyv\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("18-all-events.png", "19-preview-flap.png", "20-preview-fall.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - Fugl i listen og + ved Behaviors, derefter Platformer character
& $T -In "$O\01-fugl-object.png"      -Out "$I\01-fugl-object.png"      -Box "1141,215,222,30,1","281,304,24,24,2"
& $T -In "$O\02-add-behavior.png"     -Out "$I\02-add-behavior.png"     -Box "66,204,560,50,1"

# Opgave 1 - indstillingerne: tastaturet fra, tyngdekraft, hop
& $T -In "$O\03-platformer-settings.png" -Out "$I\03-platformer-settings.png" -Box "28,376,262,32,1","28,456,262,32,2","28,498,262,32,3"

# Opgave 2 - nyt event, Key just pressed og Space
& $T -In "$O\04-new-event.png"        -Out "$I\04-new-event.png"        -Box "40,127,112,22,1"
& $T -In "$O\05-search-key.png"       -Out "$I\05-search-key.png"       -Box "56,96,412,32,1","72,160,386,44,2"
& $T -In "$O\06-key-space.png"        -Out "$I\06-key-space.png"        -Box "493,150,642,48,1","1244,680,68,32,2"

# Opgave 2 - handlingerne: Fugl, Allow jumping again og Simulate jump key press
& $T -In "$O\07-search-jump.png"      -Out "$I\07-search-jump.png"      -Box "72,204,396,32,1","478,95,412,34,2","478,288,410,48,3"
& $T -In "$O\08-simulate-jump.png"    -Out "$I\08-simulate-jump.png"    -Box "478,338,410,48,1","1244,680,68,32,2"
& $T -In "$O\09-flap-event.png"       -Out "$I\09-flap-event.png"       -Box "576,128,270,56,1"

# Opgave 3 - mus og touch: Left, Trigger once og det faerdige event
& $T -In "$O\10-mouse-left.png"       -Out "$I\10-mouse-left.png"       -Box "72,204,386,44,1","493,150,642,48,2"
& $T -In "$O\11-trigger-once.png"     -Out "$I\11-trigger-once.png"     -Box "72,160,386,44,1"
& $T -In "$O\12-mouse-event.png"      -Out "$I\12-mouse-event.png"      -Box "576,196,270,56,1"

# Opgave 4 - fuglen vipper: Is jumping, Angle -20 og Rotate toward angle
& $T -In "$O\13-is-jumping.png"       -Out "$I\13-is-jumping.png"       -Box "478,136,410,50,1"
& $T -In "$O\14-angle-minus20.png"    -Out "$I\14-angle-minus20.png"    -Box "478,136,410,50,1","906,236,314,52,2"
& $T -In "$O\15-rotate-toward.png"    -Out "$I\15-rotate-toward.png"    -Box "478,186,410,50,1","906,160,314,52,2","906,219,314,52,3"

# Opgave 5 - kanterne: Y < 0 og saet Y til 0
& $T -In "$O\16-y-less-0.png"         -Out "$I\16-y-less-0.png"         -Box "478,136,400,50,1","906,150,398,50,2","906,206,314,52,3"
& $T -In "$O\17-set-y-0.png"          -Out "$I\17-set-y-0.png"          -Box "478,136,400,50,1","906,206,314,52,2"


""
"Faerdig. Alle markeringer for flyvespil 02-flyv er lavet forfra."
