<#
  Laver alle markeringer til flyvespillets lektion 06-menu-highscore ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\flyvespil\06-menu-highscore\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("18-preview-menu.png", "19-preview-rekord.png", "24-gdgames-page.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - scenerne: menuen ved Untitled scene, og Menu som start scene
& $T -In "$O\01-scene-menu.png"       -Out "$I\01-scene-menu.png"       -Box "284,311,24,24,1","300,497,158,24,2"
& $T -In "$O\02-start-scene.png"      -Out "$I\02-start-scene.png"      -Box "284,280,24,24,1","24,343,288,26,2"

# Opgave 2 - global highscore
& $T -In "$O\03-global-highscore.png" -Out "$I\03-global-highscore.png" -Box "70,144,1228,28,1"

# Opgave 3 - menuen: baggrundsfarve, TitelTekst og placeringen
& $T -In "$O\04-bgcolor.png"          -Out "$I\04-bgcolor.png"          -Box "1138,650,78,22,1"
& $T -In "$O\05-titeltekst.png"       -Out "$I\05-titeltekst.png"       -Box "67,132,1222,48,1","60,190,320,28,2","67,284,1222,180,3"
& $T -In "$O\06-menu-layout.png"      -Out "$I\06-menu-layout.png"      -Box "560,300,320,74,1","620,450,200,36,2","640,500,160,36,3"

# Opgave 4 - menuens events
& $T -In "$O\07-exists.png"           -Out "$I\07-exists.png"           -Box "72,160,386,44,1","493,160,714,52,2","493,219,714,52,3"
& $T -In "$O\08-load.png"             -Out "$I\08-load.png"             -Box "72,160,386,44,1","493,204,714,52,2","493,263,714,52,3","493,322,750,48,4"
& $T -In "$O\09-change-scene.png"     -Out "$I\09-change-scene.png"     -Box "493,174,642,48,1"
& $T -In "$O\10-menu-events.png"      -Out "$I\10-menu-events.png"      -Box "34,80,1320,64,1","34,148,1320,42,2","34,194,1320,92,3"

# Opgave 5 - Spil: RekordTekst, proev igen til Menu, og den nye rekord
& $T -In "$O\11-rekordtekst.png"      -Out "$I\11-rekordtekst.png"      -Box "67,132,1222,48,1","60,190,320,28,2","67,284,1222,180,3"
& $T -In "$O\12-change-to-menu.png"   -Out "$I\12-change-to-menu.png"   -Box "493,174,642,48,1"
& $T -In "$O\13-point-gt-highscore.png" -Out "$I\13-point-gt-highscore.png" -Box "493,150,750,48,1","493,206,810,48,2","493,262,727,52,3"
& $T -In "$O\14-highscore-set.png"    -Out "$I\14-highscore-set.png"    -Box "493,150,750,48,1","493,262,727,52,2"
& $T -In "$O\15-save.png"             -Out "$I\15-save.png"             -Box "72,160,386,44,1","493,204,714,111,2","493,322,727,52,3"
& $T -In "$O\16-create-rekord.png"    -Out "$I\16-create-rekord.png"    -Box "493,160,810,48,1","493,216,727,111,2","493,334,642,50,3"
& $T -In "$O\17-spil-events.png"      -Out "$I\17-spil-events.png"      -Box "576,436,190,22,1","576,504,190,22,2","34,640,1312,88,3"

# Opgave 7 - del spillet: resize mode, Share, gd.games, Publish game og linket
& $T -In "$O\20-resize-mode.png"      -Out "$I\20-resize-mode.png"      -Box "227,370,902,48,1"
& $T -In "$O\21-share.png"            -Out "$I\21-share.png"            -Box "227,192,912,70,1"
& $T -In "$O\22-gdgames.png"          -Out "$I\22-gdgames.png"          -Box "634,483,98,30,1"
& $T -In "$O\23-published.png"        -Out "$I\23-published.png"        -Box "507,301,560,36,1","507,348,102,102,2","1075,305,64,30,3"

""
"Faerdig. Alle markeringer for flyvespil 06-menu-highscore er lavet forfra."
