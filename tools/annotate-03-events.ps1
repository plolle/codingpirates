<#
  Markeringer til lektion 03-middel-events, lavet ud fra images\original\.
  Koordinater er "x,y,bredde,højde,nummer" i pixels paa det RAA billede.
#>
[CmdletBinding()]
param([string]$Root = "c:\Sandbox\Privat\codingpirates")

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\03-middel-events\images"
$O = Join-Path $I "original"
if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Billeder uden markering kopieres uaendret over
foreach ($p in @("09-finished-events.png")) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - fanen med (Events) og knappen Add an event
& $T -In "$O\01-events-tab.png"       -Out "$I\01-events-tab.png"       -Box "244,8,220,32,1","730,202,132,32,2"

# Opgave 1 - det tomme event
& $T -In "$O\02-empty-event.png"      -Out "$I\02-empty-event.png"      -Box "36,82,560,24,1","608,82,560,24,2"

# Opgave 2 - vaelg objektet i Condition-boksen
& $T -In "$O\03-condition-dialog.png" -Out "$I\03-condition-dialog.png" -Box "72,472,448,28,1"

# Opgave 2 - soegefeltet og resultatet
& $T -In "$O\04-search-condition.png" -Out "$I\04-search-condition.png" -Box "540,96,478,36,1","548,140,470,44,2"

# Opgave 2 - Ok-knappen
& $T -In "$O\05-condition-params.png" -Out "$I\05-condition-params.png" -Box "1446,662,64,30,1"

# Opgave 2 - rullemenuen med animationsnavne
& $T -In "$O\06-action-animation.png" -Out "$I\06-action-animation.png" -Box "1034,400,286,44,1"

# Opgave 3 - Invert condition
& $T -In "$O\07-invert.png"           -Out "$I\07-invert.png"           -Box "1032,226,320,30,1"

# Opgave 5 - Key-feltet
& $T -In "$O\08-control-key.png"      -Out "$I\08-control-key.png"      -Box "1034,226,286,50,1"

""
"Faerdig. Alle markeringer for 03-middel-events er lavet forfra."
