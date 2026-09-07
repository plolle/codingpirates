<#
  Markeringer til lektion 08-advanced-camera, lavet ud fra images\original\.
  Koordinater er "x,y,bredde,højde,nummer" i pixels paa det RAA billede (1544x784).

  NB: nummerbadget er 59 px i diameter (bredde/26), og det placeres til VENSTRE for
  kassen. To kasser paa nabolinjer giver derfor badges oven i hinanden - hold mindst
  ~70 px lodret afstand, eller lad kassen staa uden nummer.
#>
[CmdletBinding()]
param([string]$Root = "c:\Sandbox\Privat\codingpirates")

$T = Join-Path $Root "tools\Annotate-Screenshot.ps1"
$I = Join-Path $Root "gdevelop\08-advanced-camera\images"
$O = Join-Path $I "original"
if (-not (Test-Path $O)) { throw "Mangler mappen med originaler: $O" }

# Uden markering: de gule kommentarbjaelker er allerede gule - en gul kasse
# omkring dem forvirrer mere end den hjaelper.
foreach ($p in @("04-comments.png")) { Copy-Item (Join-Path $O $p) (Join-Path $I $p) -Force }

# Opgave 1 - skaermkanten (uden nummer: noget man skal LAEGGE MAERKE til)
# og koordinatvisningen i nederste hoejre hjoerne (nummer: noget man skal BRUGE).
# Kassen om koordinaterne skal starte foer x=1180, ellers daekker rammen det foerste ciffer.
& $T -In "$O\01-wide-level.png"        -Out "$I\01-wide-level.png"        -Box "1090,224,12,362","1174,738,84,30,1"

# Opgave 2+3 - de to actions vi skal bruge (Camera zoom naevnes kun i teksten)
& $T -In "$O\02-camera-actions.png"    -Out "$I\02-camera-actions.png"    -Box "118,248,340,44,1","118,512,300,44,2"

# Opgave 3 - de fire tal
& $T -In "$O\03-camera-boundaries.png" -Out "$I\03-camera-boundaries.png" -Box "554,148,844,230,1"

# Opgave 4 - det nye event. Uden nummer: kassen viser hvad der er NYT - og fordi den
# ikke skal have et badge, kan den starte helt ude i x=36 uden at skaere teksten over.
& $T -In "$O\05-finished-events.png"   -Out "$I\05-finished-events.png"   -Box "36,670,1490,80"

""
"Faerdig. Alle markeringer for 08-advanced-camera er lavet forfra."
