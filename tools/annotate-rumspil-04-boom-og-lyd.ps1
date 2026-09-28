<#
  Laver alle markeringer til rumspillets lektion 04-boom-og-lyd ud fra de rå billeder i
  images\original\. Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede (1366 x 768).
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\rumspil\04-boom-og-lyd\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("13-preview.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - partikler: 2D particles emitter, Red Explosion, objektet i listen, indstillinger
& $T -In "$O\01-search-particle.png"    -Out "$I\01-search-particle.png"    -Box "66,282,600,50,1"
& $T -In "$O\02-particle-presets.png"   -Out "$I\02-particle-presets.png"   -Box "528,487,145,146,1"
& $T -In "$O\03-redexplosion-list.png"  -Out "$I\03-redexplosion-list.png"  -Box "1141,374,222,30,1"
& $T -In "$O\04-eksplosion-settings.png" -Out "$I\04-eksplosion-settings.png" -Box "67,132,1222,48,1","67,286,1222,48,2","67,342,1222,48,3","64,541,230,26,4"

# Opgave 2 - lav eksplosionen, hvor asteroiden var
& $T -In "$O\05-create-explosion.png"   -Out "$I\05-create-explosion.png"   -Box "72,364,396,32,1","478,136,410,32,2","906,180,313,112,3"

# Opgave 3 - Play a sound, lyd fra asset store, volume og pitch
& $T -In "$O\06-play-sound.png"         -Out "$I\06-play-sound.png"         -Box "72,160,386,44,1","497,238,566,28,2"
& $T -In "$O\07-sound-store.png"        -Out "$I\07-sound-store.png"        -Box "67,140,1194,32,1","67,184,640,58,2","1196,677,104,32,3"
& $T -In "$O\08-sound-settings.png"     -Out "$I\08-sound-settings.png"     -Box "493,150,578,50,1","493,262,726,52,2","493,345,726,52,3"

# Opgave 4 - laserlyd
& $T -In "$O\09-laser-sounds.png"       -Out "$I\09-laser-sounds.png"       -Box "67,140,1194,32,1","67,184,640,58,2"

# Opgave 5 - musik: advarslen, Repeat, volume
& $T -In "$O\10-music.png"              -Out "$I\10-music.png"              -Box "493,142,810,90,1","1222,328,82,30,2","493,376,726,52,3"

# Opgave 6 - teksten over alt andet: Z og W
& $T -In "$O\11-text-z.png"             -Out "$I\11-text-z.png"             -Box "8,216,300,28,1","8,248,270,28,2"

# Hele koden samlet - musik, laserlyd, eksplosion
& $T -In "$O\12-events-done.png"        -Out "$I\12-events-done.png"        -Box "576,213,420,20,1","576,324,420,20,2","576,525,640,42,3"

""
"Faerdig. Alle markeringer for rumspil 04-boom-og-lyd er lavet forfra."
