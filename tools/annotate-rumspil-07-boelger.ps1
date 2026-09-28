<#
  Laver alle markeringer til rumspillets lektion 07-boelger ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\07-boelger\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("16-preview-wave2.png", "17-preview-gui.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - variablen Niveau og teksten NiveauTekst med Tween
& $T -In "$O\01-niveau-variable.png"  -Out "$I\01-niveau-variable.png"  -Box "4,389,308,26,1"
& $T -In "$O\02-niveautekst.png"      -Out "$I\02-niveautekst.png"      -Box "67,132,1222,48,1","62,188,308,32,2","67,284,1222,180,3","497,96,186,28,4"
& $T -In "$O\03-tween-search.png"     -Out "$I\03-tween-search.png"     -Box "66,140,560,50,1"
& $T -In "$O\04-tween-added.png"      -Out "$I\04-tween-added.png"      -Box "72,138,1212,136,1","1234,680,68,32,2"

# Opgave 2 - hvert 20. sekund: timeren, Niveau + 1
& $T -In "$O\05-niveau-timer.png"     -Out "$I\05-niveau-timer.png"     -Box "493,234,713,52,1","493,293,810,48,2","493,349,726,52,3"
& $T -In "$O\06-niveau-plus.png"      -Out "$I\06-niveau-plus.png"      -Box "493,150,750,48,1","493,207,810,48,2","493,263,726,50,3"

# Opgave 3 - BOELGE-teksten og fade
& $T -In "$O\07-niveau-text.png"      -Out "$I\07-niveau-text.png"      -Box "906,263,300,50,1"
& $T -In "$O\08-tween.png"            -Out "$I\08-tween.png"            -Box "478,236,410,50,1","906,293,300,50,2","906,351,313,52,3","906,467,313,50,4","1222,534,82,30,5"

# Opgave 4 - svaerere: tiden afhaenger af Niveau
& $T -In "$O\09-asteroide-time.png"   -Out "$I\09-asteroide-time.png"   -Box "493,349,726,52,1"

# Opgave 5 - pointteksten viser boelgen
& $T -In "$O\10-pointtekst.png"       -Out "$I\10-pointtekst.png"       -Box "906,263,300,74,1"

# Opgave 6 - laget GUI
& $T -In "$O\11-layers-button.png"    -Out "$I\11-layers-button.png"    -Box "1135,42,30,30,1","1328,628,26,26,2"
& $T -In "$O\12-gui-layer.png"        -Out "$I\12-gui-layer.png"        -Box "1133,488,226,28,1"
& $T -In "$O\13-pointtekst-gui.png"   -Out "$I\13-pointtekst-gui.png"   -Box "8,344,300,28,1"

# Hele koden samlet
& $T -In "$O\14-events-top.png"       -Out "$I\14-events-top.png"       -Box "578,123,510,20,1","578,299,220,20,2","40,458,330,20,3"
& $T -In "$O\15-events-bottom.png"    -Out "$I\15-events-bottom.png"    -Box "40,242,315,20,4","40,576,228,42,5"

""
"Faerdig. Alle markeringer for rumspil 07-boelger er lavet forfra."
