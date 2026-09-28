<#
  Laver alle markeringer til rumspillets lektion 01-intro ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\01-intro\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("26-preview.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - nyt projekt: Empty project, derefter navn og knappen
& $T -In "$O\01-new-game-dialog.png"  -Out "$I\01-new-game-dialog.png"  -Box "226,317,220,125,1"
& $T -In "$O\02-project-setup.png"    -Out "$I\02-project-setup.png"    -Box "453,267,224,102,1","227,392,902,48,2","1019,551,122,32,3"

# Opgave 2 - editoren: Add object
& $T -In "$O\03-editor.png"           -Out "$I\03-editor.png"           -Box "1257,183,107,30,1"

# Opgave 2 - Asset Store: soegefeltet, pakken, mapperne Ship og Background
& $T -In "$O\04-new-object.png"       -Out "$I\04-new-object.png"       -Box "178,140,1084,32,1"
& $T -In "$O\05-asset-search.png"     -Out "$I\05-asset-search.png"     -Box "66,195,238,162,1"
& $T -In "$O\06-asset-pack.png"       -Out "$I\06-asset-pack.png"       -Box "68,476,130,30,1","559,592,130,30,2"

# Opgave 2 - skibet: Blue spaceship 1 og Add to the scene
& $T -In "$O\07-ship-folder.png"      -Out "$I\07-ship-folder.png"      -Box "189,502,114,114,1"
& $T -In "$O\08-ship-asset.png"       -Out "$I\08-ship-asset.png"       -Box "1181,680,120,32,1"

# Opgave 2 - baggrunden: dark purple space
& $T -In "$O\09-background-folder.png" -Out "$I\09-background-folder.png" -Box "312,502,114,114,1"

# Opgave 3 - de to objekter i listen, og Rename i hoejrekliksmenuen
& $T -In "$O\10-objects-added.png"    -Out "$I\10-objects-added.png"    -Box "1141,215,222,62,1"
& $T -In "$O\11-rename-menu.png"      -Out "$I\11-rename-menu.png"      -Box "1141,368,202,26,1"

# Opgave 4 - baggrunden paa scenen, og dens X/Y, W/H og laasen
& $T -In "$O\12-background-placed.png" -Out "$I\12-background-placed.png" -Box "496,326,148,148,1"
& $T -In "$O\13-background-size.png"  -Out "$I\13-background-size.png"  -Box "8,184,300,28,1","8,248,300,60,2","280,117,26,26,3"

# Opgave 4 - skibet paa scenen
& $T -In "$O\14-ship-placed.png"      -Out "$I\14-ship-placed.png"      -Box "440,412,60,70,1"

# Opgave 5 - Skib i listen og + ved Behaviors, derefter Top-down movement
& $T -In "$O\15-ship-object.png"      -Out "$I\15-ship-object.png"      -Box "1141,215,222,30,1","281,304,24,24,2"
& $T -In "$O\16-add-behavior.png"     -Out "$I\16-add-behavior.png"     -Box "66,393,560,50,1"

# Opgave 5 - indstillingerne: fart op og ned, max speed, Rotate object
& $T -In "$O\17-topdown-settings.png" -Out "$I\17-topdown-settings.png" -Box "28,453,262,28,1","28,510,262,28,2","28,650,262,24,3"

# Opgave 6 - Stay on Screen: soegefeltet og behavioren, derefter kanterne
& $T -In "$O\18-search-screen.png"    -Out "$I\18-search-screen.png"    -Box "230,95,1040,34,1","66,298,300,46,2"
& $T -In "$O\19-stay-on-screen.png"   -Out "$I\19-stay-on-screen.png"   -Box "10,340,285,114,1"

# Opgave 7 - Events-fanen og Add an event, derefter Add action
& $T -In "$O\20-events-empty.png"     -Out "$I\20-events-empty.png"     -Box "236,7,216,32,1","631,196,126,36,2"
& $T -In "$O\21-new-event.png"        -Out "$I\21-new-event.png"        -Box "574,79,99,26,1","876,182,28,28,2"

# Opgave 7 - handlingen: Baggrund, soeg offset, Image X Offset
& $T -In "$O\22-action-picker.png"    -Out "$I\22-action-picker.png"    -Box "72,236,396,32,1"
& $T -In "$O\23-search-offset.png"    -Out "$I\23-search-offset.png"    -Box "478,95,410,34,1","478,136,410,48,2"
& $T -In "$O\24-offset-add-2.png"     -Out "$I\24-offset-add-2.png"     -Box "906,159,396,48,1","906,215,312,52,2","1244,680,68,32,3"

# Opgave 7 - det faerdige event
& $T -In "$O\25-event-done.png"       -Out "$I\25-event-done.png"       -Box "576,80,294,22,1"

""
"Faerdig. Alle markeringer for rumspil 01-intro er lavet forfra."
