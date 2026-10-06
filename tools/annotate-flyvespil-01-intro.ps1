<#
  Laver alle markeringer til flyvespillets lektion 01-intro ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\flyvespil\01-intro\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("23-preview.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - nyt projekt: Empty project, derefter skaermen, navnet, Pixel Art og knappen
& $T -In "$O\01-new-game-dialog.png"  -Out "$I\01-new-game-dialog.png"  -Box "226,317,220,125,1"
& $T -In "$O\02-project-setup.png"    -Out "$I\02-project-setup.png"    -Box "453,263,224,102,1","227,388,902,50,2","226,500,184,26,3","1019,555,122,32,4"

# Opgave 2 - editoren: Add object
& $T -In "$O\03-editor.png"           -Out "$I\03-editor.png"           -Box "1257,184,107,30,1"

# Opgave 2 - Asset Store: soegefeltet, pakken, mapperne Enemies og Background
& $T -In "$O\04-new-object.png"       -Out "$I\04-new-object.png"       -Box "178,140,1084,32,1"
& $T -In "$O\05-asset-search.png"     -Out "$I\05-asset-search.png"     -Box "66,195,238,162,1"
& $T -In "$O\06-asset-pack.png"       -Out "$I\06-asset-pack.png"       -Box "68,390,130,30,1","68,448,136,30,2"

# Opgave 2 - fuglen: BlueBird, animationen Flying og Add to the scene
& $T -In "$O\07-enemies-folder.png"   -Out "$I\07-enemies-folder.png"   -Box "434,292,114,114,1"
& $T -In "$O\08-bird-asset.png"       -Out "$I\08-bird-asset.png"       -Box "148,492,176,48,1","1181,680,120,32,2"

# Opgave 2 - baggrunden: Blue Background og Add to the scene
& $T -In "$O\09-background-folder.png" -Out "$I\09-background-folder.png" -Box "189,502,114,114,1"
& $T -In "$O\10-background-asset.png" -Out "$I\10-background-asset.png" -Box "1181,680,120,32,1"

# Opgave 3 - de to objekter i listen, og Rename i hoejrekliksmenuen
& $T -In "$O\11-objects-added.png"    -Out "$I\11-objects-added.png"    -Box "1141,215,222,62,1"
& $T -In "$O\12-rename-menu.png"      -Out "$I\12-rename-menu.png"      -Box "1139,368,206,26,1"

# Opgave 4 - baggrunden paa scenen, og dens X/Y, W/H og laasen
& $T -In "$O\13-background-placed.png" -Out "$I\13-background-placed.png" -Box "508,368,60,60,1"
& $T -In "$O\14-background-size.png"  -Out "$I\14-background-size.png"  -Box "8,184,300,28,1","8,248,300,60,2","280,117,26,26,3"

# Opgave 5 - fuglen paa scenen: den lille fugl, W/H og Animation
& $T -In "$O\15-bird-placed.png"      -Out "$I\15-bird-placed.png"      -Box "474,394,50,50,1","8,248,300,60,2","8,516,300,28,3"
& $T -In "$O\16-bird-settings.png"    -Out "$I\16-bird-settings.png"    -Box "8,248,300,60,1","8,516,300,28,2"

# Opgave 6 - Events-fanen og Add an event, derefter Add action
& $T -In "$O\17-events-empty.png"     -Out "$I\17-events-empty.png"     -Box "236,7,216,32,1","631,196,126,36,2"
& $T -In "$O\18-new-event.png"        -Out "$I\18-new-event.png"        -Box "578,80,96,24,1"

# Opgave 6 - handlingen: Baggrund, soeg offset, Image X Offset
& $T -In "$O\19-action-picker.png"    -Out "$I\19-action-picker.png"    -Box "72,236,396,32,1"
& $T -In "$O\20-search-offset.png"    -Out "$I\20-search-offset.png"    -Box "478,95,412,34,1","478,136,410,48,2"
& $T -In "$O\21-offset-add-2.png"     -Out "$I\21-offset-add-2.png"     -Box "906,159,398,50,1","906,215,314,52,2","1244,680,68,32,3"

# Opgave 6 - det faerdige event
& $T -In "$O\22-event-done.png"       -Out "$I\22-event-done.png"       -Box "576,80,294,22,1"

""
"Faerdig. Alle markeringer for flyvespil 01-intro er lavet forfra."
