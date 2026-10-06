<#
  Laver alle markeringer til flyvespillets lektion 05-fart-og-lyd ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\flyvespil\05-fart-og-lyd\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("15-all-events.png", "16-preview.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - variablen Fart, og de to actions der bruger den
& $T -In "$O\01-fart-variable.png"    -Out "$I\01-fart-variable.png"    -Box "4,390,308,26,1"
& $T -In "$O\02-force-fart.png"       -Out "$I\02-force-fart.png"       -Box "906,160,314,52,1"
& $T -In "$O\03-offset-fart.png"      -Out "$I\03-offset-fart.png"      -Box "906,216,314,52,1"

# Opgave 2 - timeren fart
& $T -In "$O\04-start-fart-timer.png" -Out "$I\04-start-fart-timer.png" -Box "493,150,714,52,1"
& $T -In "$O\05-event8.png"           -Out "$I\05-event8.png"           -Box "576,473,230,22,1"
& $T -In "$O\06-fart-timer-cond.png"  -Out "$I\06-fart-timer-cond.png"  -Box "493,234,714,52,1","493,293,810,48,2","493,349,727,52,3"
& $T -In "$O\07-fart-less-400.png"    -Out "$I\07-fart-less-400.png"    -Box "493,150,750,48,1","493,206,810,48,2","493,262,727,52,3"
& $T -In "$O\08-fart-add-20.png"      -Out "$I\08-fart-add-20.png"      -Box "493,150,750,48,1","493,206,810,48,2","493,262,727,52,3"
& $T -In "$O\09-fart-event.png"       -Out "$I\09-fart-event.png"       -Box "34,684,1310,44,1"

# Opgave 3 - lyd: Play a sound, asset store, Jump 1.aac og indstillingerne
& $T -In "$O\10-play-sound.png"       -Out "$I\10-play-sound.png"       -Box "72,160,386,44,1","497,238,566,28,2"
& $T -In "$O\11-jump-sound.png"       -Out "$I\11-jump-sound.png"       -Box "140,140,1122,32,1","67,180,1222,66,2","1197,678,102,30,3"
& $T -In "$O\12-jump-settings.png"    -Out "$I\12-jump-settings.png"    -Box "493,150,578,48,1","493,262,727,52,2","493,346,727,52,3"

# Opgave 4 - lyd paa Game Over og paa point
& $T -In "$O\13-hit-sound.png"        -Out "$I\13-hit-sound.png"        -Box "493,150,578,48,1","493,262,727,52,2"
& $T -In "$O\14-coin-sound.png"       -Out "$I\14-coin-sound.png"       -Box "493,150,578,48,1","493,262,727,52,2"

""
"Faerdig. Alle markeringer for flyvespil 05-fart-og-lyd er lavet forfra."