<#
  Laver alle markeringer til flyvespillets lektion 03-stolper ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\flyvespil\03-stolper\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("14-all-events.png", "15-preview.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - Asset Store: mappen Terrain, Green Grass 9Patch og Add to the scene
& $T -In "$O\01-pack-terrain.png"     -Out "$I\01-pack-terrain.png"     -Box "684,274,110,30,1"
& $T -In "$O\02-terrain-folder.png"   -Out "$I\02-terrain-folder.png"   -Box "66,352,146,146,1"
& $T -In "$O\03-grass-asset.png"      -Out "$I\03-grass-asset.png"      -Box "1181,680,120,32,1"

# Opgave 1 - objektet i listen, og dets standardstoerrelse
& $T -In "$O\04-object-added.png"     -Out "$I\04-object-added.png"     -Box "1141,247,222,30,1"
& $T -In "$O\05-stolpe-size.png"      -Out "$I\05-stolpe-size.png"      -Box "1141,247,222,30,1","8,331,290,28,2"

# Opgave 2 - timeren startes ved scenens start
& $T -In "$O\06-search-beginning.png" -Out "$I\06-search-beginning.png" -Box "72,160,386,44,1"
& $T -In "$O\07-start-timer.png"      -Out "$I\07-start-timer.png"      -Box "72,424,386,44,1","493,150,714,52,2"

# Opgave 3 - timeren er over 1.6, og de to stolper laves
& $T -In "$O\08-timer-condition.png"  -Out "$I\08-timer-condition.png"  -Box "72,248,396,44,1","493,234,714,52,2","493,293,810,48,3","493,349,727,52,4"
& $T -In "$O\09-create-bottom.png"    -Out "$I\09-create-bottom.png"    -Box "493,160,810,48,1","493,216,727,52,2","493,275,727,52,3"
& $T -In "$O\10-create-top.png"       -Out "$I\10-create-top.png"       -Box "493,275,727,52,1"

# Opgave 4 - stolperne flytter sig, og de gamle slettes
& $T -In "$O\11-force.png"            -Out "$I\11-force.png"            -Box "72,236,396,32,1","478,136,410,50,2","906,160,314,112,3","912,316,70,32,4"
& $T -In "$O\12-x-less.png"           -Out "$I\12-x-less.png"           -Box "478,136,400,50,1","906,150,398,50,2","906,206,314,52,3"
& $T -In "$O\13-delete.png"           -Out "$I\13-delete.png"           -Box "478,136,410,50,1"

""
"Faerdig. Alle markeringer for flyvespil 03-stolper er lavet forfra."