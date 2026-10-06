# Originale skærmbilleder — uden markeringer

Disse filer er de rå skærmbilleder, præcis som de blev taget, uden gule kasser og tal.
De bruges ikke af lektionen — de ligger her, så markeringerne altid kan fortrydes.

Billederne er taget i browserudgaven på editor.gdevelop.io i oktober 2026, i et vindue
på 1366 x 768. Reklamerne på gd.games er maskeret væk med en ensfarvet firkant.

## Lav markeringerne igen

```powershell
& "c:\Sandbox\Privat\codingpirates\tools\annotate-flyvespil-06-menu-highscore.ps1"
```

Scriptet laver alle markeringer forfra ud fra denne mappe og kopierer de billeder,
der ikke skal markeres, uændret over. Koordinaterne står som kommentarer i scriptet.

## Fortryd markeringerne helt

```powershell
Copy-Item ".\*.png" ".." -Force
```

## Tag nye skærmbilleder

`tools\import-flyvespil-06-menu-highscore-shots.ps1` henter skærmbilleder ind og maskerer de områder,
der ikke må offentliggøres. Skiftes et billede ud, skal koordinaterne i
`annotate-flyvespil-06-menu-highscore.ps1` måles om.
