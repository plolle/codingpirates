<#
  Laver alle markeringer til rumspillets lektion 08-menu-highscore ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\08-menu-highscore\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("17-preview-menu.png", "18-preview-rekord.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - scener: Rename, ny scene, start scene
& $T -In "$O\01-scene-menu.png"        -Out "$I\01-scene-menu.png"        -Box "284,311,24,24,1","302,497,154,26,2"
& $T -In "$O\02-start-scene.png"       -Out "$I\02-start-scene.png"       -Box "282,280,28,26,1","38,343,272,26,2"

# Opgave 2 - den globale variabel Highscore
& $T -In "$O\03-global-highscore.png"  -Out "$I\03-global-highscore.png"  -Box "70,145,1228,28,1"

# Opgave 3 - menuen: baggrundsfarve, titlen, placeringen
& $T -In "$O\04-bgcolor.png"           -Out "$I\04-bgcolor.png"           -Box "1138,650,78,22,1"
& $T -In "$O\05-titeltekst.png"        -Out "$I\05-titeltekst.png"        -Box "67,132,1222,48,1","62,188,308,32,2","67,284,1222,180,3"
& $T -In "$O\06-menu-layout.png"       -Out "$I\06-menu-layout.png"       -Box "1141,215,222,94,1"

# Opgave 4 - menuens events: findes den, indlaes, Enter, skift scene
& $T -In "$O\07-exists.png"            -Out "$I\07-exists.png"            -Box "72,160,386,44,1","493,160,713,52,2","493,243,713,52,3"
& $T -In "$O\08-load.png"              -Out "$I\08-load.png"              -Box "72,160,386,44,1","493,204,713,110,2","493,322,750,50,3"
& $T -In "$O\09-just-pressed.png"      -Out "$I\09-just-pressed.png"      -Box "72,160,386,44,1","493,150,642,50,2"
& $T -In "$O\10-change-scene.png"      -Out "$I\10-change-scene.png"      -Box "493,174,642,48,1"
& $T -In "$O\11-menu-events.png"       -Out "$I\11-menu-events.png"       -Box "34,80,1322,58,1","34,148,1322,40,2","34,194,1322,42,3"

# Opgave 5 - Game Over: proev igen-teksten paa laget GUI
& $T -In "$O\12-igen-create.png"       -Out "$I\12-igen-create.png"       -Box "72,396,386,32,1","906,180,313,112,2","906,298,229,48,3"

# Opgave 6 - ny rekord: Point > Highscore, Highscore = Point, gem
& $T -In "$O\13-point-gt-highscore.png" -Out "$I\13-point-gt-highscore.png" -Box "493,150,750,48,1","493,207,810,48,2","493,263,726,50,3"
& $T -In "$O\14-highscore-set.png"     -Out "$I\14-highscore-set.png"     -Box "493,150,750,48,1","493,263,726,50,2"
& $T -In "$O\15-save.png"              -Out "$I\15-save.png"              -Box "72,160,386,44,1","493,204,713,110,2","493,322,726,52,3"

# Hele koden samlet - de nye events i Spil
& $T -In "$O\16-spil-events.png"       -Out "$I\16-spil-events.png"       -Box "40,573,260,64,1","40,663,215,42,2"

""
"Faerdig. Alle markeringer for rumspil 08-menu-highscore er lavet forfra."
