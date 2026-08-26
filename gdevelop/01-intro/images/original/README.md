# Originale skærmbilleder — uden markeringer

Disse filer er de rå skærmbilleder, præcis som de blev hentet, uden gule kasser og tal.
De bruges ikke af lektionen — de ligger her, så markeringerne altid kan fortrydes.

## Fortryd markeringerne (tilbage til rå billeder)

```powershell
Copy-Item "c:\Sandbox\Privat\codingpirates\gdevelop\01-intro\images\original\*.png" `
          "c:\Sandbox\Privat\codingpirates\gdevelop\01-intro\images\" -Force
```

Bemærk: `05-objects-list.png` findes kun som markeret udgave. Den er lavet ud fra
`05-save-as.png` med en anden markering. Efter en fortrydelse skal den laves igen:

```powershell
& "c:\Sandbox\Privat\codingpirates\tools\Annotate-Screenshot.ps1" `
    -In  ".\original\05-save-as.png" `
    -Out ".\05-objects-list.png" `
    -Box "1578,100,336,700,1"
```

## Lav markeringerne igen

Alle kommandoerne for denne lektion står i
[`tools/annotate-01-intro.ps1`](../../../tools/annotate-01-intro.ps1).
Kør det script, og alle markeringer bliver lavet forfra ud fra `original\`.
