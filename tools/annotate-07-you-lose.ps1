<#
  Markeringer til lektion 07-advanced-you-lose, lavet ud fra images\original\.
  Koordinater er "x,y,bredde,højde,nummer" i pixels paa det RAA billede (1544x784).

  NB: nummerbadget er 59 px i diameter (bredde/26). To bokse paa nabolinjer giver
  derfor badges der ligger oven i hinanden - se lektion 06. Her er hvert billede
  holdt paa EN markering, saa det ikke kan ske.
#>
[CmdletBinding()]
param([string]$Root = "c:\Sandbox\Privat\codingpirates")

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\07-advanced-you-lose\images"
$O = Join-Path $I "original"
if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Uden markering: maalet for scenen, og det faerdige event der taler for sig selv
$plain = @("02-you-lose-scene.png", "04-try-again-event.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 2 - farvevaelgeren: den hvide firkant i paletten og Hex-feltet
& $T -In "$O\01-lose-text.png"       -Out "$I\01-lose-text.png"       -Box "326,352,220,126,1"

# Opgave 3 - Name of the new scene.
# NB: Action-boksen har to spalter, saa parameterfeltet starter ved x=556 -
# ikke ved x=1024 som i Condition-boksen, der har tre.
& $T -In "$O\03-change-scene.png"    -Out "$I\03-change-scene.png"    -Box "556,170,758,52,1"

# Opgave 5 - Sign of the test og Value to compare i samme kasse
& $T -In "$O\05-y-position.png"      -Out "$I\05-y-position.png"      -Box "1024,152,456,102,1"

# Opgave 4+5 - de to nye events nederst i Game.
# Uden nummer: kassen viser hvad der er NYT, ikke hvor man skal klikke.
& $T -In "$O\06-death-events.png"    -Out "$I\06-death-events.png"    -Box "36,628,1490,112"

""
"Faerdig. Alle markeringer for 07-advanced-you-lose er lavet forfra."
