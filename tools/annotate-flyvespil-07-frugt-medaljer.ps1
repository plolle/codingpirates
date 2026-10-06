<#
  Laver alle markeringer til flyvespillets lektion 07-frugt-medaljer ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\flyvespil\07-frugt-medaljer\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("18-preview-frugt.png", "19-preview-medalje.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - Asset Store: mappen Item, Apple og Add to the scene, og Frugt i listen
& $T -In "$O\01-pack-item.png"        -Out "$I\01-pack-item.png"        -Box "560,332,100,30,1"
& $T -In "$O\02-item-folder.png"      -Out "$I\02-item-folder.png"      -Box "803,416,112,112,1"
& $T -In "$O\03-apple.png"            -Out "$I\03-apple.png"            -Box "1183,682,116,28,1"
& $T -In "$O\04-frugt-object.png"     -Out "$I\04-frugt-object.png"     -Box "1141,390,214,30,1"

# Opgave 2 - frugten laves, bliver stoerre og flyver med
& $T -In "$O\05-create-frugt.png"     -Out "$I\05-create-frugt.png"     -Box "493,160,810,48,1","493,216,727,52,2","493,275,727,52,3"
& $T -In "$O\06-scale.png"            -Out "$I\06-scale.png"            -Box "72,396,396,32,1","478,136,410,48,2","906,262,314,52,3"
& $T -In "$O\07-frugt-force.png"      -Out "$I\07-frugt-force.png"      -Box "72,396,396,32,1","906,160,314,112,2"
& $T -In "$O\08-ev9-and-10.png"       -Out "$I\08-ev9-and-10.png"       -Box "576,627,660,44,1","576,718,500,22,2"

# Opgave 3 - saml frugten
& $T -In "$O\09-collision-frugt.png"  -Out "$I\09-collision-frugt.png"  -Box "72,204,396,32,1","478,128,410,32,2","906,160,398,48,3"
& $T -In "$O\10-point-add-3.png"      -Out "$I\10-point-add-3.png"      -Box "493,150,750,48,1","493,206,810,48,2","493,262,727,52,3"
& $T -In "$O\11-coin-pitch.png"       -Out "$I\11-coin-pitch.png"       -Box "493,150,578,48,1","493,346,727,52,2"
& $T -In "$O\12-frugt-events.png"     -Out "$I\12-frugt-events.png"     -Box "34,572,1310,44,1","34,618,1310,110,2"

# Opgave 4 - medaljer: teksten, conditions, tekst og farve, og alle tre events
& $T -In "$O\13-medaljetekst.png"     -Out "$I\13-medaljetekst.png"     -Box "67,132,1222,48,1","60,190,320,28,2","67,537,607,48,3"
& $T -In "$O\14-point-ge-5.png"       -Out "$I\14-point-ge-5.png"       -Box "493,150,750,48,1","493,206,810,48,2","493,262,727,52,3"
& $T -In "$O\15-medalje-text.png"     -Out "$I\15-medalje-text.png"     -Box "72,428,396,32,1","906,262,300,52,2"
& $T -In "$O\16-medalje-color.png"    -Out "$I\16-medalje-color.png"    -Box "478,136,410,50,1","906,160,250,52,2"
& $T -In "$O\17-medal-events.png"     -Out "$I\17-medal-events.png"     -Box "34,418,1310,108,1","34,529,1310,108,2","34,640,1310,88,3"

""
"Faerdig. Alle markeringer for flyvespil 07-frugt-medaljer er lavet forfra."
