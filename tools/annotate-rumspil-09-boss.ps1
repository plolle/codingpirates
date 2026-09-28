<#
  Laver alle markeringer til rumspillets lektion 09-boss ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\09-boss\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("11-preview-lynskud.png", "12-preview-boss.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - power-ups: Bolt Yellow Powerup, og Lynskud med DestroyOutside
& $T -In "$O\01-powerups-folder.png"  -Out "$I\01-powerups-folder.png"  -Box "681,502,112,114,1"
& $T -In "$O\02-lynskud.png"          -Out "$I\02-lynskud.png"          -Box "1141,238,222,62,1","10,340,290,122,2"

# Opgave 2 - variablerne Skudtid og BossLiv
& $T -In "$O\03-variables.png"        -Out "$I\03-variables.png"        -Box "4,419,308,58,1"

# Opgave 3 - lynskud: timeren sammenlignes med Skudtid
& $T -In "$O\04-skudtid.png"          -Out "$I\04-skudtid.png"          -Box "493,349,726,52,1"

# Opgave 4 - power-up-events
& $T -In "$O\05-events-powerups.png"  -Out "$I\05-events-powerups.png"  -Box "40,382,260,20,1","40,472,245,20,2","578,583,340,20,3","578,672,340,42,4"

# Opgave 5 - bossen: Red spaceship 2, skala 2, stop ved X 900
& $T -In "$O\06-boss-asset.png"       -Out "$I\06-boss-asset.png"       -Box "66,510,146,142,1"
& $T -In "$O\07-scale.png"            -Out "$I\07-scale.png"            -Box "478,136,410,48,1","906,263,313,50,2"
& $T -In "$O\08-boss-x.png"           -Out "$I\08-boss-x.png"           -Box "478,136,410,48,1","906,150,396,48,2","906,207,313,50,3"

# Hele koden samlet
& $T -In "$O\09-events-top.png"       -Out "$I\09-events-top.png"       -Box "578,188,640,42,1","578,364,240,42,2","40,452,240,20,3"
& $T -In "$O\10-events-boss.png"      -Out "$I\10-events-boss.png"      -Box "40,110,208,42,4","40,243,215,20,5","40,290,244,20,6","40,401,235,20,7","40,512,215,42,8"

""
"Faerdig. Alle markeringer for rumspil 09-boss er lavet forfra."
