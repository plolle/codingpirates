<#
  Markeringer til lektion 05-middel-fjender, lavet ud fra images\original\.
  Koordinater er "x,y,bredde,højde,nummer" i pixels paa det RAA billede.
#>
[CmdletBinding()]
param([string]$Root = "c:\Sandbox\Privat\codingpirates")

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\05-middel-fjender\images"
$O = Join-Path $I "original"
if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Uden markering: den faerdige oversigt
foreach ($p in @("09-finished-events.png")) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - hus-ikonet og de to pile i soegeresultatet
& $T -In "$O\01-arrow-search.png"      -Out "$I\01-arrow-search.png"      -Box "232,144,30,30,1","780,452,120,102,2","906,452,120,102,3"

# Opgave 1 - knappen Add to the scene
& $T -In "$O\02-add-arrow.png"         -Out "$I\02-add-arrow.png"         -Box "1288,662,132,30,1"

# Opgave 3 - knappen Add a variable paa fanen Variables
& $T -In "$O\03-object-variables.png"  -Out "$I\03-object-variables.png"  -Box "784,96,314,30,1","714,414,140,32,2"

# Opgave 3 - navn, type og vaerdi
& $T -In "$O\04-boolean-variable.png"  -Out "$I\04-boolean-variable.png"  -Box "158,184,494,28,1","654,184,124,28,2","780,184,120,28,3"

# Opgave 4 - True/False i stedet for et tal
& $T -In "$O\05-boolean-condition.png" -Out "$I\05-boolean-condition.png" -Box "1390,220,110,30,1"

# Opgave 4 - Instant kontra Permanent
& $T -In "$O\06-add-force.png"         -Out "$I\06-add-force.png"         -Box "1040,346,74,38,1"

# Opgave 4 - farten paa X og Y
& $T -In "$O\07-force-values.png"      -Out "$I\07-force-values.png"      -Box "1034,164,376,52,1","1034,226,376,52,2"

# Opgave 5 - operatoren der saetter en boolean
& $T -In "$O\08-set-boolean.png"       -Out "$I\08-set-boolean.png"       -Box "1034,330,458,50,1"

""
"Faerdig. Alle markeringer for 05-middel-fjender er lavet forfra."
