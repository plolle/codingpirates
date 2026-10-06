<#
  Henter skærmbillederne til flyvespillets lektion 07-frugt-medaljer ind.

  - kopierer PNG-filerne fra Playwright-mappen og giver dem lektionens navne
  - lægger dem i images\original\ (de rå udgaver, uden gule markeringer)

  Kør derefter annotate-flyvespil-07-frugt-medaljer.ps1 for at lave markeringerne.
#>
[CmdletBinding()]
param(
  [string]$Src = "c:\Sandbox\Privat\codingpirates\.playwright-mcp\fs07",
  [string]$Root = "c:\Sandbox\Privat\codingpirates"
)

Add-Type -AssemblyName System.Drawing

$dest = Join-Path $Root "gdevelop\flyvespil\07-frugt-medaljer\images\original"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

# kildefil -> nyt filnavn. Ingen af billederne har noget, der skal maskeres.
$map = @(
  @{ From = "01-pack-item.png";          Name = "01-pack-item.png" }
  @{ From = "02-item-folder.png";        Name = "02-item-folder.png" }
  @{ From = "03-apple.png";              Name = "03-apple.png" }
  @{ From = "04-frugt-object.png";       Name = "04-frugt-object.png" }
  @{ From = "05-create-frugt.png";       Name = "05-create-frugt.png" }
  @{ From = "06-scale.png";              Name = "06-scale.png" }
  @{ From = "07-frugt-force.png";        Name = "07-frugt-force.png" }
  @{ From = "19-ev9-and-10.png";         Name = "08-ev9-and-10.png" }
  @{ From = "08-collision-frugt.png";    Name = "09-collision-frugt.png" }
  @{ From = "09-point-add-3.png";        Name = "10-point-add-3.png" }
  @{ From = "10-coin-pitch.png";         Name = "11-coin-pitch.png" }
  @{ From = "11-frugt-events.png";       Name = "12-frugt-events.png" }
  @{ From = "12-medaljetekst.png";       Name = "13-medaljetekst.png" }
  @{ From = "13-point-ge-5.png";         Name = "14-point-ge-5.png" }
  @{ From = "14-medalje-text.png";       Name = "15-medalje-text.png" }
  @{ From = "15-medalje-color.png";      Name = "16-medalje-color.png" }
  @{ From = "18-medal-events.png";       Name = "17-medal-events.png" }
  @{ From = "pv-1.png";                  Name = "18-preview-frugt.png" }
  @{ From = "pv-2.png";                  Name = "19-preview-medalje.png" }
)

foreach ($m in $map) {
  $file = Join-Path $Src $m.From
  if (-not (Test-Path $file)) { Write-Warning "Fandt ikke kilden $($m.From)"; continue }
  Copy-Item $file (Join-Path $dest $m.Name) -Force
  "{0,-28} <- {1}" -f $m.Name, $m.From
}
