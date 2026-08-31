# GDevelop — byg dit eget platformspil 🎮

Her lærer du at lave dit eget computerspil. Du starter med en helt tom skærm og ender med
et rigtigt platformspil, som du kan sende til dine venner.

Du behøver **ikke** at kunne programmere i forvejen.

<p class="cta"><a href="01-intro/">Start med lektion 1 &rarr;</a></p>

---

## Det skal du bygge

Et platformspil med:

- 🏃 En helt, der kan løbe, hoppe og klatre op ad stiger
- 🪙 Mønter, du kan samle, og en score på skærmen
- 👾 Fjender, der går på patrulje — og som du kan hoppe oven på
- ❤️ Tre liv, vist som hjerter, og ekstra liv du kan samle op
- 🚪 En dør, der først åbner, når du har samlet mønter nok
- 🏁 En startmenu og en **You Win**- og **You Lose**-skærm

Undervejs lærer du, hvordan rigtige spil er bygget op: objekter, *events*, variabler,
scener og et kamera, der følger spilleren.

---

## Det skal du have

- En computer med **Windows**, **Mac** eller **Linux**
- **GDevelop** — hentes gratis på [gdevelop.io/download](https://gdevelop.io/download)
- Internet, i hvert fald første gang, så du kan hente grafikken til spillet

Kurset bruger **programmet på din egen computer**. Så ligger dit spil som en almindelig fil
hos dig, du skal ikke logge ind, og du kan arbejde videre uden internet.

---

## Sådan læser du opgaverne

**Knapperne står på engelsk.** GDevelop findes ikke på dansk, så vi skriver knappernes
navne præcis som de står på skærmen — fx **Create project** — mens forklaringerne er på
dansk. Så kan du altid finde den rigtige knap.

**🟡 De gule kasser viser, hvor du skal klikke.** Tallene i de gule cirkler passer til
tallene i teksten, fx **(1)** og **(2)**.

**Menuen til venstre** viser alle lektionerne. Den lektion, du er inde i, er markeret, og
under den kan du hoppe direkte ned til de enkelte opgaver.

---

## Vejen gennem kurset

Tag lektionerne i rækkefølge — hver bygger videre på den før.

| Del | Lektioner | Det handler om |
|---|---|---|
| **Kom i gang** | 1–2 | Lav projektet, hent grafikken, og gør helten og platformene klar |
| **Middel** | 3–5 | Få helten til at bevæge sig, saml mønter med score, og lav fjender |
| **Advanced** | 6–10 | Flere baner, menu, kamera, en låst dør og liv med hjerter |

De lektioner, der er grå i menuen til venstre, er ikke skrevet færdig endnu.

---

## Gode råd

- **Gem ofte.** Tryk **Ctrl + S**, hver gang du har lavet noget, der virker.
- **Prøv spillet tidligt.** Tryk **Preview** ofte i stedet for at bygge længe i blinde.
- **Der er ingen dumme fejl.** Går noget i stykker, så fortryd med **Ctrl + Z**, og prøv igen.
- **Spørg din nabo.** Tit kan man se en andens fejl hurtigere end sin egen.
- **Byg videre.** Når kurset er slut, er spillet dit. Lav flere baner, nye fjender eller
  din helt egen grafik.

---

## Kan man køre GDevelop i browseren?

Ja — GDevelop findes også som en hjemmeside på
**[editor.gdevelop.io](https://editor.gdevelop.io)**, hvor du intet skal installere.
**Men vi bruger den ikke i dette kursus**, og det er der tre grunde til:

- Du **skal have en konto** og logge ind, før du overhovedet kan lave et projekt.
- Spillet gemmes i skyen, og en gratis konto kan kun have **3 projekter** ad gangen.
- Tegneprogrammet **Piskel**, som vi bruger til at lave egne figurer, virker slet ikke i
  browseren.

Har du brug for browserudgaven alligevel — fx på en computer, hvor du ikke må installere
noget — kan du følge opgaverne næsten uændret. Editoren ser ens ud. Det eneste, du skal
gøre anderledes, er at gemme i **GDevelop Cloud** i stedet for i en mappe.

---

## Om kurset

Opgaverne bygger på det oprindelige GDevelop-forløb fra
**[mom2day.dk/gdevelop](https://mom2day.dk/gdevelop)** — stor tak for et rigtig godt
udgangspunkt. 🙏

Denne udgave er skrevet om, så den passer til den version af GDevelop, der er ude nu:
menuerne og knapperne har skiftet navn og plads flere steder siden det oprindelige forløb
blev lavet.

---

## Til undervisere

Hver lektion er én mappe med en `README.md` og de skærmbilleder, der hører til, så en
lektion kan køres uden forberedelse.

Skærmbillederne har gule markeringer, der peger på den knap, opgaven handler om. De rå
billeder uden markeringer ligger altid i `<lektion>/images/original/`, og markeringerne
laves med scripterne i
[`tools/`](https://github.com/plolle/codingpirates/tree/main/tools) — så de kan flyttes,
laves om eller fjernes igen.
