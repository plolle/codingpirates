<#
  Laver alle markeringer til rumspillets lektion 06-fjender ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Bokse uden nummer er "x,y,bredde,højde". Skiftes et skærmbillede ud, skal
  koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\06-fjender\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("18-preview.png", "19-preview-enemy-laser.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - fjenden og dens laser
& $T -In "$O\01-enemies-folder.png"     -Out "$I\01-enemies-folder.png"     -Box "66,502,114,114,1"
& $T -In "$O\02-fjende-in-list.png"     -Out "$I\02-fjende-in-list.png"     -Box "1141,470,222,30,1"
& $T -In "$O\03-red-lasers.png"         -Out "$I\03-red-lasers.png"         -Box "189,418,114,114,1"
& $T -In "$O\04-fjendelaser.png"        -Out "$I\04-fjendelaser.png"        -Box "1141,502,222,30,1","10,340,290,122,2"

# Opgave 2 - gruppen Fjender
& $T -In "$O\05-groups-panel.png"       -Out "$I\05-groups-panel.png"       -Box "1044,42,30,30,1","1336,530,26,26,2"
& $T -In "$O\06-group-dialog.png"       -Out "$I\06-group-dialog.png"       -Box "407,210,552,48,1","407,415,552,40,2","407,470,552,64,3","894,568,66,30,4"

# Opgave 3 - event 5 og 6 bruger gruppen
& $T -In "$O\07-cond-fjender.png"       -Out "$I\07-cond-fjender.png"       -Box "906,160,396,48,1","72,588,396,32,2"
& $T -In "$O\08-events-group.png"       -Out "$I\08-events-group.png"       -Box "40,484,238,20,1","578,504,114,20,2","578,569,600,20,3","40,617,232,20","578,616,114,20","578,680,600,20"

# Opgave 4 - en fjende hvert 3. sekund
& $T -In "$O\09-create-fjende.png"      -Out "$I\09-create-fjende.png"      -Box "72,460,396,32,1","478,136,410,32,2","906,180,313,112,3"
& $T -In "$O\10-object-timer.png"       -Out "$I\10-object-timer.png"       -Box "478,286,410,48,1","906,160,300,52,2"
& $T -In "$O\11-flip.png"               -Out "$I\11-flip.png"               -Box "478,136,410,48,1","1222,215,82,30,2"

# Opgave 5 - boelgebevaegelsen
& $T -In "$O\12-wave-force.png"         -Out "$I\12-wave-force.png"         -Box "906,160,313,134,1","912,340,68,30,2"

# Opgave 6 - fjenderne skyder
& $T -In "$O\13-objtimer-cond.png"      -Out "$I\13-objtimer-cond.png"      -Box "478,186,410,48,1","906,253,300,52,2","906,313,396,48,3","906,369,313,52,4"
& $T -In "$O\14-create-fjendelaser.png" -Out "$I\14-create-fjendelaser.png" -Box "72,492,396,32,1","478,136,410,32,2","906,180,313,112,3"
& $T -In "$O\15-laser-hits-ship.png"    -Out "$I\15-laser-hits-ship.png"    -Box "72,492,396,32,1","478,136,410,48,2","906,160,396,48,3"

# Hele koden samlet
& $T -In "$O\16-events-top.png"         -Out "$I\16-events-top.png"         -Box "578,166,640,20,1","578,278,210,20,2"
& $T -In "$O\17-events-bottom.png"      -Out "$I\17-events-bottom.png"      -Box "40,397,215,20,3","40,530,295,20,4","40,641,275,20,5"

""
"Faerdig. Alle markeringer for rumspil 06-fjender er lavet forfra."
