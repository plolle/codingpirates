<#
  Laver alle markeringer til lektion 02-begynder ud fra images\original\.
  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\02-begynder\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Billeder uden markering kopieres uaendret over
$plain = @("03-collision-custom.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 2 - objektboksen: knappen Edit collision masks
& $T -In "$O\01-object-editor.png"        -Out "$I\01-object-editor.png"        -Box "156,596,136,30,1"

# Opgave 2 - beskeden om at masken er automatisk
& $T -In "$O\02-collision-auto.png"       -Out "$I\02-collision-auto.png"       -Box "1000,186,410,66,1"

# Opgave 3 - fanen Behaviors og knappen Add a behavior
& $T -In "$O\04-behaviors-empty.png"      -Out "$I\04-behaviors-empty.png"      -Box "470,96,314,30,1","714,390,140,32,2"

# Opgave 3 - de to naesten ens behaviors
& $T -In "$O\05-behavior-list.png"        -Out "$I\05-behavior-list.png"        -Box "160,208,1230,50,1"

# Opgave 3 - afkrydsningsfeltet der skal vaere tomt
& $T -In "$O\06-platformer-character.png" -Out "$I\06-platformer-character.png" -Box "176,308,268,28,1"

# Opgave 5 - Type-feltet foer aendringen
& $T -In "$O\07-platform-behavior.png"    -Out "$I\07-platform-behavior.png"    -Box "180,314,1200,48,1"

# Opgave 5 - Jumpthru valgt, og hakket fjernet
& $T -In "$O\08-jumpthru.png"             -Out "$I\08-jumpthru.png"             -Box "180,314,1200,48,1","176,402,268,28,2"

""
"Faerdig. Alle markeringer for 02-begynder er lavet forfra."
