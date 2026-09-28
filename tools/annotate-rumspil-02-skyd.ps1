<#
  Laver alle markeringer til rumspillets lektion 02-skyd ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\02-skyd\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("15-preview.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - laseren: Blue laser 01, Add to the scene, Laser i listen
& $T -In "$O\01-lasers-folder.png"     -Out "$I\01-lasers-folder.png"     -Box "66,502,114,114,1"
& $T -In "$O\02-laser-asset.png"       -Out "$I\02-laser-asset.png"       -Box "1181,680,120,32,1"
& $T -In "$O\03-laser-in-list.png"     -Out "$I\03-laser-in-list.png"     -Box "1141,246,222,30,1"

# Opgave 2 - Destroy when outside of the screen, og behavioren bagefter
& $T -In "$O\04-add-behavior.png"      -Out "$I\04-add-behavior.png"      -Box "66,428,570,50,1"
& $T -In "$O\05-destroy-behavior.png"  -Out "$I\05-destroy-behavior.png"  -Box "10,340,290,122,1"

# Opgave 3 - nyt event, At the beginning of the scene, timeren "skud"
& $T -In "$O\06-new-event.png"         -Out "$I\06-new-event.png"         -Box "34,126,1322,24,1"
& $T -In "$O\07-beginning-condition.png" -Out "$I\07-beginning-condition.png" -Box "72,160,386,44,1","1244,680,68,32,2"
& $T -In "$O\08-start-timer.png"       -Out "$I\08-start-timer.png"       -Box "72,292,386,44,1","493,150,713,52,2"
& $T -In "$O\09-start-event.png"       -Out "$I\09-start-event.png"       -Box "34,126,1322,46,1"

# Opgave 4 - Space og timeren > 0.25
& $T -In "$O\10-key-space.png"         -Out "$I\10-key-space.png"         -Box "72,204,386,44,1","493,160,642,48,2"
& $T -In "$O\11-timer-condition.png"   -Out "$I\11-timer-condition.png"   -Box "72,204,386,44,1","493,234,713,52,2","493,293,810,48,3","493,349,726,52,4"

# Opgave 5 - Create an object ved skibets midte, og kraften mod hoejre
& $T -In "$O\12-create-laser.png"      -Out "$I\12-create-laser.png"      -Box "72,236,396,32,1","478,136,410,32,2","906,180,313,112,3"
& $T -In "$O\13-force.png"             -Out "$I\13-force.png"             -Box "478,136,410,48,1","906,160,313,112,2","912,435,88,30,3"

# Hele koden samlet - event 3
& $T -In "$O\14-events-done.png"       -Out "$I\14-events-done.png"       -Box "34,172,1322,90,1"

""
"Faerdig. Alle markeringer for rumspil 02-skyd er lavet forfra."
