# OPGAVER TIL GDevelop – INTRO

Velkommen! I denne første del gør du GDevelop klar, laver dit projekt og henter den grafik,
vi skal bruge til vores platformspil. Når du er færdig, er du klar til at bygge selve spillet.

Alle knapper i GDevelop står på engelsk. Derfor skriver vi knappernes navne **præcis som de
står på skærmen** — fx **Create new game** — mens forklaringerne er på dansk.

> 🟡 **Om billederne:** de gule kasser viser, hvor du skal klikke. Tallene i de gule cirkler
> passer til tallene i teksten, fx **(1)** og **(2)**.

---

## Opgave 1 – INTRO: Hent og installér GDevelop

Vi bruger **programmet på din egen computer**. Så ligger dit spil som en almindelig fil på
maskinen, du behøver ikke logge ind, og du kan arbejde videre, selvom der ikke er internet.

1. Gå ind på **[gdevelop.io/download](https://gdevelop.io/download)**
2. Hent udgaven til **Windows**, og installér den.
3. Start **GDevelop** fra Start-menuen.

> 💡 **Står dine knapper på dansk?** Så passer de ikke til vejledningen, for vi skriver alle
> knapnavne på engelsk. Gå til **Preferences** nederst i menuen til venstre, og sæt sproget
> til **English**.

> 📷 **Om skærmbillederne:** de er taget i browserudgaven af GDevelop. Programmet på din PC
> ser præcis ens ud — den eneste forskel, du vil lægge mærke til, er i **Opgave 2**, hvor du
> vælger, *hvor* spillet skal gemmes.

---

## Opgave 2 – INTRO: Lav dit første projekt

I menuen til venstre er der fem punkter: **Learn**, **Create**, **Play**, **Shop** og
**Teach**.

1. Vælg **Create** **(1)** i menuen til venstre.
2. Tryk på knappen **+ Create new game** **(2)** ude til højre.

![Create-siden i GDevelop med menuen til venstre og knappen Create new game til højre](images/01-create-page.png)

> 💡 Der er meget andet på siden — et felt der hedder **What would you like to create?**,
> hvor en robot kan lave spillet for dig, og en **Wallet** med mønter. Det skal vi ikke
> bruge. Vi bygger selv!

3. Nu åbner boksen **Create a new game**. Vælg **Empty project** — det tomme projekt.

![Boksen Create a new game med Empty project øverst til venstre og en række færdige skabeloner](images/02-new-game-dialog.png)

> ⚠️ Der ligger også en skabelon, der hedder **Platformer**. Den lyder rigtig — men vælg
> den **ikke**! Så er spillet nemlig lavet på forhånd, og så er der ikke noget tilbage at
> lære. Vi starter fra bunden.

4. Lad skærmstørrelsen stå på **Desktop & Mobile landscape (1280x720)**.
5. I feltet **Project name** **(1)** står der et tilfældigt navn, fx *Didactic Structure*.
   **Slet det**, og skriv i stedet: `Platformspil1`
6. I feltet **Where to store this project** **(2)** vælger du **din egen computer** — og
   peger på en mappe, du kan finde igen, fx `Dokumenter\GDevelop`.
7. Tryk på **Create new game** **(3)**.

![Boksen med Project name udfyldt med Platformspil1, gemmested og knappen Create new game](images/03-project-setup.png)

> ⚠️ **På billedet står der GDevelop Cloud** — det er fordi billedet er taget i browseren.
> I programmet skal du vælge **din egen computer** i stedet, så spillet bliver gemt som en
> fil hos dig.

Nu åbner editoren, og du har en tom scene foran dig. Det er her, spillet skal bygges.

![GDevelops editor med en tom scene i midten og Objects-panelet til højre](images/04-editor.png)

Læg mærke til de tre steder, du skal bruge hele kurset igennem:

- **(1)** **Objects**-panelet i **højre** side — her bor alle spillets figurer og klodser
- **(2)** **Preview**-knappen **øverst** — den starter spillet, så du kan prøve det
- **(3)** **☰**-knappen **helt oppe i venstre hjørne** — det er **Project manager**, hvor du
  gemmer og finder dine scener

---

## Opgave 3 – INTRO: Hent grafik til spillet

"Assets" er den grafik, spillet er bygget af: figuren, jorden, mønterne, stigen og så videre.
Dem henter vi færdige, så vi ikke selv skal tegne dem.

1. Find **Objects**-panelet i højre side.
2. Tryk på **+ Add object**.
3. Boksen **New object** åbner på fanen **Asset Store**.

![Boksen New object med fanen Asset Store og kategorierne](images/05-new-object.png)

4. Skriv `GDevelop Platformer` i søgefeltet **Search assets**, og tryk **Enter**.
5. Øverst i resultatet ser du pakken **GDevelop Platformer** med **15 Assets**. Klik på den.

![Søgeresultatet med pakken GDevelop Platformer og de 15 figurer under den](images/06-asset-search.png)

> ⚠️ Der findes flere platformer-pakker i **Asset Store**. De er også fine, men resten af
> kurset bruger grafikken fra **GDevelop Platformer**, så vælg den.

6. Nu ser du pakkens side. Den er lavet af GDevelop og er gratis (**CC0**).
7. Tryk på den blå knap nederst til højre: **Add these assets to my scene**.

![Pakkens side med knappen Add these assets to my scene nederst til højre](images/07-asset-pack.png)

8. GDevelop spørger, om du er sikker: *"You're about to add 15 assets."*
   Tryk på **Add the assets**.

![Boksen der spørger om du vil tilføje 15 assets](images/08-add-confirm.png)

9. Tryk på **Close** for at lukke Asset Store igen.

**Sådan ved du, at det gik godt:** i **Objects**-panelet til højre står der nu 15 figurer
under **Scene Objects**:

`Monster` · `GreenHero` · `Moon` · `Clouds` · `Fly` · `Checkpoint` · `Coin` · `Door` ·
`Red_hero` · `Ladder` · `Corner_platform` · `Platform_1` · `Platform_2` · `Platform_3` ·
`Background`

![Objects-panelet til højre fyldt med de 15 figurer fra pakken](images/09-objects-list.png)

> 💡 Læg mærke til, at der er **to** helte: `Red_hero` og `GreenHero`. Vi bruger
> **`Red_hero`** i resten af kurset. Læg også mærke til understregerne i navnene —
> det hedder `Platform_1`, ikke `Platform1`.

---

## Opgave 4 – INTRO: Gem dit projekt

Den nemmeste måde: tryk **Ctrl + S**.

Du kan også gøre det gennem menuen:

1. Tryk på **☰** helt oppe i venstre hjørne. Nu åbner **Project manager**.

![Project manager med fanerne File, View og Help og en oversigt over spillet](images/10-project-manager.png)

2. Vælg fanen **File** øverst.
3. Vælg **Save**.

![File-menuen med punkterne Save og Save as...](images/11-file-menu.png)

I samme menu finder du også:

- **Save as…** — gem en ekstra kopi under et nyt navn
- **Export (web, iOS, Android)…** — lav spillet færdigt, så andre kan spille det

> 💡 Gør det til en vane at trykke **Ctrl + S**, hver gang du har lavet noget, der virker.
> Så mister du aldrig mere end et par minutters arbejde.

**Sådan ved du, at det er gemt:** stjernen `*` efter projektets navn i fanen forsvinder.

**Hvor ligger spillet nu?** I den mappe, du valgte i Opgave 2. Tag et kig i mappen — der
ligger projektfilen sammen med den grafik, du hentede. Den mappe er hele dit spil, så flyt
den ikke, uden at tage det hele med.

---

## Prøv at det virker

Tryk på **Preview** øverst i værktøjslinjen. Spillet starter i et nyt vindue.

Der sker ingenting endnu — og det er helt rigtigt! Vi har kun *hentet* figurerne, ikke
*placeret* dem i scenen. Så længe vinduet åbner uden en fejlbesked, er alt som det skal være.
Luk vinduet igen.

---

## Du er færdig med INTRO ✅

Sæt et flueben ved hver ting, du har klaret:

- [ ] GDevelop er installeret på min computer
- [ ] Jeg har et projekt, der hedder **Platformspil1**
- [ ] Jeg ved, hvilken mappe projektet ligger i
- [ ] Alle 15 figurer fra **GDevelop Platformer** står i **Objects**-panelet
- [ ] Projektet er gemt
- [ ] **Preview** åbner uden fejl

**Nu skal vi i gang med at bygge vores spil!**

👉 Gå videre til **BEGYNDER**, hvor du lærer at sætte dine objekter ordentligt op med
*behaviors* og *collision masks*.

---

## Hvis noget går galt

| Problem | Løsning |
|---|---|
| Jeg kan ikke finde **+ Create new game** | Du står nok på **Learn**. Vælg **Create** i menuen til venstre først. |
| Knappen **Create new game** er grå og kan ikke trykkes | Du har ikke valgt et gemmested. Vælg **din egen computer** under **Where to store this project**. |
| GDevelop vil have, at jeg logger ind | Det behøver du ikke. Log ind-knapperne er kun til dem, der vil gemme i skyen — vi gemmer på maskinen. |
| Mine knapper er på dansk | Gå til **Preferences** nederst til venstre, og sæt sproget til **English**. |
| Jeg kan ikke finde mit projekt igen | Kig i den mappe, du valgte i Opgave 2. Du kan også åbne det med **☰ → File → Open…** |
| **Asset Store** er tom eller loader ikke | Den kræver internet — også når programmet er installeret. Tjek din forbindelse, og prøv igen. |
| Jeg valgte **Platformer**-skabelonen ved en fejl | Luk projektet, og start Opgave 2 forfra med **Empty project**. |
| Jeg kan ikke finde `RedHero` | Den hedder `Red_hero` med en understreg. |
| **Objects**-panelet er væk | Slå det til igen i **View**-menuen inde i **Project manager**. |

---

Opgaverne bygger på det oprindelige GDevelop-forløb fra
[mom2day.dk/gdevelop](https://mom2day.dk/gdevelop). 🙏
