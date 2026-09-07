<#
  Markeringer til lektion 09-advanced-door, lavet ud fra images\original\.
  Koordinater er "x,y,bredde,højde,nummer" i pixels paa det RAA billede (1544x784).

  NB: nummerbadget er 59 px i diameter (bredde/26) og placeres til VENSTRE for kassen
  (ellers til hoejre, saa over/under). Hold mindst ~70 px lodret afstand mellem to
  kasser i samme spalte, eller lad kassen staa uden nummer.
#>
[CmdletBinding()]
param([string]$Root = "c:\Sandbox\Privat\codingpirates")

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\09-advanced-door\images"
$O = Join-Path $I "original"
if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Opgave 1 - hele Layers-panelet: plusset og de to lag.
# Kassen skal starte foer x=1276, ellers skaerer rammen ordet "Layers" over.
& $T -In "$O\01-layers-gui.png"         -Out "$I\01-layers-gui.png"         -Box "1272,436,266,152,1"

# Opgave 1 - lagvaelgeren paa selve instansen (badget lander til hoejre for kassen)
& $T -In "$O\02-instance-layer.png"     -Out "$I\02-instance-layer.png"     -Box "10,344,340,30,1"

# Opgave 2+3 - doeren og beskeden
& $T -In "$O\03-scene-with-door.png"    -Out "$I\03-scene-with-door.png"    -Box "1152,410,64,84,1","618,348,200,28,2"

# Opgave 4 - variabel, tegn og tal i samme kasse
& $T -In "$O\04-variable-condition.png" -Out "$I\04-variable-condition.png" -Box "554,148,868,178,1"

# Opgave 4 - de tre nye events. Uden nummer: kassen viser hvad der er NYT.
& $T -In "$O\05-door-events.png"        -Out "$I\05-door-events.png"        -Box "36,522,1490,224"

""
"Faerdig. Alle markeringer for 09-advanced-door er lavet forfra."
