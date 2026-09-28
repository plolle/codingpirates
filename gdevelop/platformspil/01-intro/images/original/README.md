# Originale skærmbilleder — uden markeringer

Disse filer er de rå skærmbilleder, præcis som de blev taget, uden gule kasser og tal.
De bruges ikke af lektionen — de ligger her, så markeringerne altid kan fortrydes.

Billederne er taget i browserudgaven på editor.gdevelop.io i august 2026.
E-mailadresse og navnet på et privat projekt er maskeret væk med en ensfarvet firkant.

## Lav markeringerne igen

```powershell
& "c:\Sandbox\Privat\codingpirates\tools\annotate-01-intro.ps1"
```

Scriptet laver alle markeringer forfra ud fra denne mappe og kopierer de billeder,
der ikke skal markeres, uændret over. Koordinaterne står som kommentarer i scriptet.

## Fortryd markeringerne helt

```powershell
Copy-Item ".\*.png" ".." -Force
```

## Tag nye skærmbilleder

`tools\import-01-intro-shots.ps1` henter skærmbilleder ind, konverterer til PNG og
maskerer de områder, der ikke må offentliggøres. Skiftes et billede ud, skal
koordinaterne i `annotate-01-intro.ps1` måles om.
