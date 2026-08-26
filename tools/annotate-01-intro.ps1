<#
  Laver alle markeringer til lektion 01-intro ud fra de rå billeder i images\original\.
  Kør det igen hvis markeringerne skal fortrydes, flyttes eller laves om.

  Koordinaterne er "x,y,bredde,højde,nummer" i pixels på det RÅ billede.
  Skiftes et skærmbillede ud, skal koordinaterne måles om.
#>
[CmdletBinding()]
param(
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\01-intro\images"
$O = Join-Path $I "original"

if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Opgave 2 — New Project: navnefeltet, derefter knappen
& $T -In "$O\01-create-a-project.png"   -Out "$I\01-create-a-project.png"   -Box "20,72,720,62,1","616,152,126,36,2"

# Opgave 2 — de tre steder i editoren: Objects, Preview, Project manager
& $T -In "$O\02-start-screen.png"       -Out "$I\02-start-screen.png"       -Box "1578,100,336,700,1","872,10,120,38,2","6,8,44,40,3"

# Opgave 3 — Asset Store: søgefeltet, derefter pakken
& $T -In "$O\03-add-new-object.png"     -Out "$I\03-add-new-object.png"     -Box "60,116,1132,40,1","80,222,358,250,2"

# Opgave 3 — pakkesiden: tilføj alt, derefter luk
& $T -In "$O\04-asset-pack.png"         -Out "$I\04-asset-pack.png"         -Box "972,779,222,38,1","886,781,78,34,2"

# Opgave 3 — samme skærmbillede, men her peger vi paa objektlisten
& $T -In "$O\05-save-as.png"            -Out "$I\05-objects-list.png"       -Box "1578,100,336,700,1"

# Opgave 4 — samme skærmbillede, her peger vi paa menupunktet Save as...
& $T -In "$O\05-save-as.png"            -Out "$I\05-save-as.png"            -Box "10,85,380,32,1"

# Opgave 4 — gemmestedet, derefter download-knappen
& $T -In "$O\06-download-a-copy.png"    -Out "$I\06-download-a-copy.png"    -Box "28,413,700,74,1"
& $T -In "$O\07-download-game-file.png" -Out "$I\07-download-game-file.png" -Box "20,108,712,36,1"

""
"Faerdig. Alle markeringer for 01-intro er lavet forfra."
