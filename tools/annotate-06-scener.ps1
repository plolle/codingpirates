<#
  Markeringer til lektion 06-advanced-scener, lavet ud fra images\original\.
  Koordinater er "x,y,bredde,højde,nummer" i pixels paa det RAA billede (1544x784).
#>
[CmdletBinding()]
param([string]$Root = "c:\Sandbox\Privat\codingpirates")

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\06-advanced-scener\images"
$O = Join-Path $I "original"
if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Uden markering: den faerdige oversigt over fire scener
foreach ($p in @("03-four-scenes.png", "07-menu-event.png")) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - hamburgeren og de tre prikker paa scenens linje
& $T -In "$O\01-scenes-panel.png"     -Out "$I\01-scenes-panel.png"     -Box "6,6,24,22,1","228,250,20,20,2"

# Opgave 1 - kun Rename. Set as start scene naevnes i teksten og har sit eget billede i
# Opgave 3; to kasser paa nabolinjer faar numrene til at ligge oven i hinanden.
& $T -In "$O\02-scene-menu.png"       -Out "$I\02-scene-menu.png"       -Box "244,398,124,20,1"

# Opgave 3 - flaget der markerer startscenen
& $T -In "$O\04-start-scene-flag.png" -Out "$I\04-start-scene-flag.png" -Box "206,276,26,20,1"

# Opgave 4 - Background color i Properties
& $T -In "$O\05-background-color.png" -Out "$I\05-background-color.png" -Box "8,192,338,24,1"

# Opgave 5 - navn, stoerrelse og starttekst
& $T -In "$O\06-start-text.png"       -Out "$I\06-start-text.png"       -Box "156,140,1224,36,1","152,192,140,26,2","156,288,1224,44,3"

# Opgave 6 - det faerdige event
# (07-menu-event.png staar uden markering - se listen $plain ovenfor. To kasser side om
#  side daekker teksten med numrene, og eventet er selvforklarende.)

""
"Faerdig. Alle markeringer for 06-advanced-scener er lavet forfra."
