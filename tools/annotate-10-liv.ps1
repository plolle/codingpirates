<#
  Markeringer til lektion 10-advanced-liv, lavet ud fra images\original\.
  Koordinater er "x,y,bredde,højde,nummer" i pixels paa det RAA billede.

  NB: billederne har to stoerrelser - 01 og 02 er 1544x784, resten 1568x750.
  Nummerbadget er bredde/26 (59-60 px) og placeres til VENSTRE for kassen, ellers
  til hoejre, ellers over/under. Hold ~70 px lodret afstand mellem to kasser i
  samme spalte - eller lad kassen staa uden nummer.
#>
[CmdletBinding()]
param([string]$Root = "c:\Sandbox\Privat\codingpirates")

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\10-advanced-liv\images"
$O = Join-Path $I "original"
if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Opgave 2 - hjerterne oppe i hjoernet og hjertet man kan samle
& $T -In "$O\01-hearts-scene.png"      -Out "$I\01-hearts-scene.png"      -Box "975,248,110,34,1","1012,390,34,32,2"

# Opgave 3 - plusset i Scene Variables, og den faerdige linje
& $T -In "$O\02-scene-variable.png"    -Out "$I\02-scene-variable.png"    -Box "325,271,22,22,1","6,342,346,28,2"

# Opgave 4 - de to variabler med hver sit ikon (scene kontra globus)
& $T -In "$O\03-variable-dropdown.png" -Out "$I\03-variable-dropdown.png" -Box "565,208,300,76,1"

# Opgave 4 - variabel, tegn og tal i samme kasse
& $T -In "$O\04-subtract-life.png"     -Out "$I\04-subtract-life.png"     -Box "558,158,872,160,1"

# Opgave 4+5 - det aendrede monster-event og de tre nye events.
# Uden numre: kasserne viser hvad der er NYT, og et badge kan ikke ligge
# uden for et event der fylder hele bredden.
& $T -In "$O\05-heart-events.png"      -Out "$I\05-heart-events.png"      -Box "36,126,1500,86","36,592,1500,155"

""
"Faerdig. Alle markeringer for 10-advanced-liv er lavet forfra."
