<#
  Laver alle markeringer til lektion 01-intro ud fra de rå billeder i images\original\.
  Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede.
  Skiftes et skærmbillede ud, skal koordinaterne måles om.

  De billeder der ikke staar her, bruges uden markering - de viser en hel skaerm
  eller en boks hvor der ikke er én bestemt knap at pege paa.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\01-intro\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Kopier de billeder der ikke skal have markeringer, uaendret over
$plain = @("02-new-game-dialog.png", "05-new-object.png", "08-add-confirm.png", "10-project-manager.png")
foreach ($p in $plain) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 2 - Create-siden: menupunktet Create, derefter knappen
& $T -In "$O\01-create-page.png"     -Out "$I\01-create-page.png"     -Box "9,128,220,26,1","1356,401,136,28,2"

# Opgave 2 - projektopsaetning: navnefelt, gemmested, knappen
& $T -In "$O\03-project-setup.png"   -Out "$I\03-project-setup.png"   -Box "319,384,930,44,1","319,442,930,46,2","1130,547,118,30,3"

# Opgave 2 - editoren: Objects-panelet, Preview, projektmenuen
& $T -In "$O\04-editor.png"          -Out "$I\04-editor.png"          -Box "1294,84,272,660,1","686,44,106,30,2","8,8,30,28,3"

# Opgave 3 - soegeresultat: pakken GDevelop Platformer
& $T -In "$O\06-asset-search.png"    -Out "$I\06-asset-search.png"    -Box "155,196,242,164,1"

# Opgave 3 - pakkesiden: knappen der tilfoejer alle figurer
& $T -In "$O\07-asset-pack.png"      -Out "$I\07-asset-pack.png"      -Box "1220,662,192,30,1"

# Opgave 3 - objektlisten efter at figurerne er hentet
& $T -In "$O\09-objects-list.png"    -Out "$I\09-objects-list.png"    -Box "1294,216,272,494,1"

# Opgave 4 - File-menuen: Save
& $T -In "$O\11-file-menu.png"       -Out "$I\11-file-menu.png"       -Box "56,188,298,26,1"

""
"Faerdig. Alle markeringer for 01-intro er lavet forfra."
