<#
  Markeringer til lektion 04-middel-variabler, lavet ud fra images\original\.
  Koordinater er "x,y,bredde,højde,nummer" i pixels paa det RAA billede.
#>
[CmdletBinding()]
param([string]$Root = "c:\Sandbox\Privat\codingpirates")

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\04-middel-variabler\images"
$O = Join-Path $I "original"
if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Uden markering: den faerdige oversigt og advarslen taler for sig selv
foreach ($p in @("11-finished-events.png")) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - fanen New object from scratch
& $T -In "$O\01-new-object-scratch.png" -Out "$I\01-new-object-scratch.png" -Box "786,96,626,30,1"

# Opgave 1 - objekttypen Text
& $T -In "$O\02-text-object.png"        -Out "$I\02-text-object.png"        -Box "160,198,700,52,1"

# Opgave 1 - navn, stoerrelse og starttekst
& $T -In "$O\03-edit-text.png"          -Out "$I\03-edit-text.png"          -Box "155,140,1250,44,1","152,194,140,30,2","155,292,1250,50,3"

# Opgave 2 - knappen Add a variable
& $T -In "$O\04-global-variables.png"   -Out "$I\04-global-variables.png"   -Box "714,394,140,34,1"

# Opgave 2 - navn, type og vaerdi
& $T -In "$O\05-add-variable.png"       -Out "$I\05-add-variable.png"       -Box "158,148,494,28,1","654,148,124,28,2","780,148,120,28,3"

# Opgave 2 - advarslen om ens navne
& $T -In "$O\06-name-warning.png"       -Out "$I\06-name-warning.png"       -Box "560,204,880,26,1"

# Opgave 3 - variabelfeltet med forslaget Score
& $T -In "$O\07-change-variable.png"    -Out "$I\07-change-variable.png"    -Box "566,206,860,36,1"

# Opgave 4 - vaelg objektet Coin
& $T -In "$O\08-collision.png"          -Out "$I\08-collision.png"          -Box "1040,436,440,30,1"

# Opgave 4 - plus (add) og vaerdien 1
& $T -In "$O\09-add-one.png"            -Out "$I\09-add-one.png"            -Box "560,214,932,44,1","560,272,860,44,2"

# Opgave 5 - udtrykket
# bemaerk: 10 og 11 er taget i PROGRAMMET (1920x1140), ikke i browseren som de oevrige
& $T -In "$O\10-text-expression.png"    -Out "$I\10-text-expression.png"    -Box "1276,330,442,64,1"

""
"Faerdig. Alle markeringer for 04-middel-variabler er lavet forfra."
