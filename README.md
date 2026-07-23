# Rurku-docs

Repozytorium dokumentacji projektu rakietowego. Tu trzymamy decyzje, wymagania i wyniki testów — żeby zespół nie polegał na pamięci i czacie.

## Dokumenty (szablony LaTeX)

| Folder | Dokument | Build |
| --- | --- | --- |
| [`1_SRD/`](1_SRD/) | System Requirements Document | `make` → `Rurku_SRD.pdf` |
| [`2_CONOPS/`](2_CONOPS/) | Concept of Operations | `make` → `Rurku_CONOPS.pdf` |
| [`3_SAD/`](3_SAD/) | System Architecture Document | `make` → `Rurku_SAD.pdf` |
| [`4_TPTR/`](4_TPTR/) | Test Plan + Test Report | `make` → `Rurku_TPTR.pdf` |
| [`5_ICD/`](5_ICD/) | Interface Control Document | `make` → `Rurku_ICD.pdf` |

---

## Uruchomienie / budowa PDF

Wspólne wymaganie: `make`, `latexmk`, TeX Live (pdflatex). Logo: `common/simbalogo.png`.

### Budowanie z katalogu głównego

Wszystkie dokumenty można zbudować z poziomu repozytorium jednym poleceniem:

```bash
make all
```

Wyniki budowy można oczyścić:

```bash
make clean
```

Można też zbudować pojedynczy PDF z katalogu głównego, podając nazwę folderu dokumentu:

```bash
make 1_SRD
make 2_CONOPS
make 3_SAD
make 4_TPTR
make 5_ICD
```

### Diff względem `master` (latexdiff)

PDF z zaznaczonymi zmianami względem gałęzi `master` (wymaga `latexdiff` / `latexdiff-vc`).
Wynik trafia do `diff_release/`:

```bash
# jeden dokument
cd 1_SRD && make diff          # → diff_release/Rurku_SRD_diff.pdf

# wszystkie dokumenty z katalogu głównego
make diff

# inny ref niż master
make diff DIFF_REF=origin/master
cd 4_TPTR && make diff DIFF_REF=v0.2
```

### Opcja A — Dev Container / Docker (Windows/Linux/MacOS)

Najprostsza droga do jednakowego środowiska. Używamy gotowego obrazu:

`ghcr.io/simba-avionic/simba_avionics_dockers/latex_devcontainer:1.5.0`

(konfiguracja: [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json)).

#### Cursor / VS Code (zalecane)

1. Zainstaluj [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   (Macos czasami widzi Dockera jako malware - [rozwiązanie](https://github.com/docker/for-mac/issues/7527))
   (Windows: włącz WSL2 backend) albo Docker Engine (Linux i Mac).
2. Otwórz to repo w Cursor / VS Code.
3. Command Palette → **Dev Containers: Reopen in Container**
   (pierwsze uruchomienie ściąga obraz ~z GHCR).
   (VS Code potrafi się zwiesić na "Connecting to Dev Container", restart apki pomaga)
4. W terminalu kontenera:

```bash
cd 1_SRD && make
cd ../2_CONOPS && make
cd ../3_SAD && make
cd ../4_TPTR && make
cd ../5_ICD && make
```

### Wydanie (tag → GitHub Release)

Workflow [`.github/workflows/release-docs.yml`](.github/workflows/release-docs.yml)
buduje wszystkie PDF-y przy pushu taga w formacie `vMAJOR.MINOR` (np. `v1.0`, `v1.1` —
**nie** `v1.1.1`) i tworzy GitHub Release
z assetami w formacie `Nazwa_wersja.pdf`:

- `Rurku_SRD_v1.0.pdf`
- `Rurku_CONOPS_v1.0.pdf`
- `Rurku_SAD_v1.0.pdf`
- `Rurku_TPTR_v1.0.pdf`
- `Rurku_ICD_v1.0.pdf`

```bash
git tag v1.0
git push origin v1.0
```

Build w CI używa tego samego obrazu GHCR. Przy prywatnym pakiecie
`GITHUB_TOKEN` musi mieć `packages: read` do org.

---

### Opcja B — lokalnie, bez Dockera

#### Linux (Debian / Ubuntu)

```bash
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  make latexmk \
  texlive-binaries texlive-latex-extra \
  texlive-fonts-recommended texlive-fonts-extra \
  texlive-lang-polish \
  texlive-xetex texlive-plain-generic texlive-bibtex-extra
```

Potem:

```bash
cd 1_SRD && make
cd ../2_CONOPS && make
cd ../3_SAD && make
cd ../4_TPTR && make
cd ../5_ICD && make
```

Opcjonalnie (jak w obrazie Dockera) czcionki MS:

```bash
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" \
  | sudo debconf-set-selections
sudo apt-get install -y ttf-mscorefonts-installer fontconfig
```

#### Windows

**Zalecane: WSL2 (Ubuntu)** — te same komendy co Linux powyżej, w katalogu
repo zamontowanym w WSL (np. `/home/.../Rurku-docs` albo
`/mnt/c/Users/.../Rurku-docs`).

Natywnie (bez WSL):

1. Zainstaluj [TeX Live](https://tug.org/texlive/) albo [MiKTeX](https://miktex.org/)
   (z `latexmk`).
2. Zainstaluj `make` (np. przez [Chocolatey](https://chocolatey.org/):
   `choco install make`, albo użyj Git Bash / MSYS2).
3. W PowerShell / cmd:

```powershell
cd 1_SRD
make
cd ..\2_CONOPS
make
cd ..\3_SAD
make
cd ..\4_TPTR
make
cd ..\5_ICD
make
```

Jeśli `make` nie działa, w każdym folderze dokumentu:

```powershell
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build srd.tex
copy build\srd.pdf Rurku_SRD.pdf
```

(dla CONOPS: `conops.tex` → `Rurku_CONOPS.pdf`; SAD: `sad.tex` → `Rurku_SAD.pdf`; TPTR: `tptr.tex` → `Rurku_TPTR.pdf`; ICD: `icd.tex` → `Rurku_ICD.pdf`).

---

### Czyszczenie

```bash
cd 1_SRD && make clean
cd ../2_CONOPS && make clean
cd ../3_SAD && make clean
cd ../4_TPTR && make clean
cd ../5_ICD && make clean
```

---

## Jak z tego korzystać (merytorycznie)

1. **Zanim coś zmienisz w projekcie** — sprawdź, czy zmiana nie łamie wymagań (SRD) albo opisanego przebiegu misji (CONOPS).
2. **Zanim zaczniesz projektować podsystem** — zerknij na CONOPS (jak to ma działać) i na architekturę systemu (mapa podziału odpowiedzialności).
3. **Przed każdym testem** — uzupełnij plan testu; po teście — raport. To jest główne źródło wiedzy o tym, co naprawdę działa.

Dokumenty poniżej to nie „biurokracja” — to sposób, żeby uniknąć typowych katastrof: ciągłej zmiany założeń, rozjazdu „jak to ma działać w dniu lotu” i utraty wniosków z testów.

---

## 1. System Requirements Document (SRD)

**Pytanie, na które odpowiada:** *Co budujemy?*

**Po co:** Bez spisanych wymagań łatwo wpadać w ciągłe zmiany założeń (np. 1 km → 3 km, etanol → RP-1, spadochron → lądowanie aktywne). SRD jest punktem odniesienia przy większych decyzjach projektowych.

**Co powinno zawierać:** mierzalne wymagania, np.:
- wysokość apogeum ≥ 1000 m
- impuls całkowity ≥ X Ns
- masa startowa ≤ Y kg
- odzysk rakiety bez uszkodzeń krytycznych

**Kiedy aktualizować:** gdy zespół świadomie zmienia cel misji albo kryteria sukcesu — nie „po cichu” w trakcie projektowania.

Szablon: [`1_SRD/`](1_SRD/).

---

## 2. Concept of Operations (CONOPS)

**Pytanie, na które odpowiada:** *Jak dochodzimy do lotu — od testów do dnia na poligonie?*

**Po co:** CONOPS opisuje całą kampanię operacyjną: cold-flow, static fire, pakowanie na konkurs, plan dzień po dniu na miejscu oraz countdown / odzysk. Bez tego każdy ma inną wizję „jak to ma wyglądać”, a procedury i hardware powstają pod sprzeczne założenia.

**Co powinno zawierać:**
- mapę etapów kampanii i warunki przejścia (go/no-go między etapami)
- cold-flow i static fire (cel, timeline, obsada, awarie)
- pakowanie na konkurs (packing list, transport, odpowiedzialności)
- plan na każdy dzień na miejscu (setup → dry run → okno lotu → pack-up)
- role, tryby pracy, scenariusze awaryjne
- założenia o strefach bezpieczeństwa i łączności

**Kiedy aktualizować:** gdy zmienia się kolejność testów, procedury stanowiskowe, packing albo harmonogram na konkursie — zanim etap pójdzie „na żywioł”.

Szablon: [`2_CONOPS/`](2_CONOPS/).

---

## 3. System Architecture Document (SAD)

**Pytanie, na które odpowiada:** *Jak podzielony jest system?*

**Po co:** To mapa projektu — kto za co odpowiada i jak podsystemy się układają. Nowi ludzie i osoby z innych podsystemów mają tu szybki przegląd całości.

**Co powinno zawierać:**
- podział na podsystemy i ich zależności, np.:

```
Rakieta
├── Propulsion
├── Tanks
├── Feed System
├── Avionics
├── Recovery
└── Ground Support Equipment
```

- diagramy blokowe / kontekstowe
- schemat przepływu paliwa (P&ID-lite)
- schemat elektryczny / danych wysokiego poziomu
- rejestr interfejsów (szczegóły → ICD)
- budżety masy / mocy / objętości
- mapowanie wymagań SRD → bloki architektury

**Czego tu nie duplikować:** tabele Must/Should (SRD), timeline i role na padzie (CONOPS), procedury i wyniki testów (TPTR), pinouty (ICD).

**Kiedy aktualizować:** gdy dodajesz / usuwasz podsystem albo zmieniasz granice odpowiedzialności między nimi.

Szablon: [`3_SAD/`](3_SAD/).

---

## 4. Test Plan + Test Report

**Pytanie, na które odpowiadają:** *Co sprawdzamy i czego się nauczyliśmy?*

**Po co:** Po roku pracy większość realnej wiedzy o projekcie pochodzi z historii testów, nie z założeń. Plan i raport to jeden proces — nie dwa luźne pliki.

### Przed testem (plan)

- cel testu
- konfiguracja
- procedura
- kryteria sukcesu / porażki

### Po teście (raport)

- wyniki
- wykresy
- zdjęcia
- anomalie
- wnioski (co zmienić w projekcie / kolejnym teście)

**Zasada:** nie ma „testu bez papieru” — nawet szybki check powinien mieć krótki zapis, inaczej za miesiąc nikt nie będzie wiedział, co wyszło.

Szablon LaTeX: [`4_TPTR/`](4_TPTR/) (`make` → `Rurku_TPTR.pdf`).

---

## 5. Interface Control Document (ICD)

**Pytanie, na które odpowiada:** *Jak dokładnie łączą się bloki systemu?*

**Po co:** ICD rejestruje, definiuje i kontroluje informacje o interfejsach między systemami, podsystemami, sprzętem albo oprogramowaniem ([Wikipedia](https://en.wikipedia.org/wiki/Interface_control_document)). To wspólny punkt odniesienia przy integracji: różne zespoły mogą osobno budować strony złącza, ale muszą się zgadzać co do sygnałów, protokołów, mechaniki i odpowiedzialności. Bez tego „u nas działa” pada na stole integracyjnym.

W systems engineering interfejs to wspólna granica jednostek funkcjonalnych — cechy funkcyjne, wymiana sygnałów / danych / mediów i inne atrybuty techniczne. ICD wspiera integrację, weryfikację, walidację oraz zarządzanie konfiguracją i zmianami.

**Co powinno zawierać** (treść zależy od typu złącza; typowy zestaw):
- identyfikacja interfejsu (ID z rejestru SAD, np. `IF-00x`)
- strony złącza (bloki / właściciele po obu stronach)
- sygnały wejścia / wyjścia; komunikaty i protokoły
- typy danych, jednostki, skale, limity i tolerancje
- częstotliwość / okres transmisji
- złącza i cechy fizyczne (wymiary, montaż, MEOP, napięcia, prądy)
- diagramy, rysunki, tabele
- odpowiedzialności stron
- historia zatwierdzonych zmian

**Typy interfejsów do opisania:**
- fizyczne / mechaniczne (złącza, punkty montażu, wymiary)
- elektryczne (napięcia, prądy, sygnały dyskretne, zasilanie)
- fluidyczne (przyłącza, media, ciśnienia — typowe u nas: FEED ↔ GSE / PROP)
- dane / komunikacja (protokoły, magistrale, format wiadomości)
- hardware–software (rejestry, sensory, aktuatory)
- opcjonalnie HMI (operator ↔ panel GSE), jeśli to krytyczne dla kompatybilności

**Czego tu nie duplikować:** mapa podziału podsystemów i budżety (SAD); Must/Should (SRD); procedury na padzie (CONOPS); wyniki testów (TPTR). ICD opisuje *rozwiązanie interfejsu*; wymagania wysokiego poziomu zostają w SRD (ew. osobny IRD nie jest nam na start potrzebny).

**Kiedy aktualizować:** przy każdej zmianie pinoutu, protokołu, fittingu, limitu albo strony odpowiedzialnej — z analizą wpływu na drugą stronę złącza (configuration / change control). Zatwierdzona zmiana interfejsu bez aktualizacji ICD to błąd procesu.

Szablon: [`5_ICD/`](5_ICD/) (`make` → `Rurku_ICD.pdf`).

