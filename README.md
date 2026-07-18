# Rurku-docs

Repozytorium dokumentacji projektu rakietowego. Tu trzymamy decyzje, wymagania i wyniki testów — żeby zespół nie polegał na pamięci i czacie.

## Dokumenty (szablony LaTeX)

| Folder | Dokument | Build |
| --- | --- | --- |
| [`1_SRD/`](1_SRD/) | System Requirements Document | `make` → `Rurku_SRD.pdf` |
| [`2_CONOPS/`](2_CONOPS/) | Concept of Operations | `make` → `Rurku_CONOPS.pdf` |
| [`4_TPTR/`](4_TPTR/) | Test Plan + Test Report | `make` → `Rurku_TPTR.pdf` |

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
make 4_TPTR
```

### Opcja A — Dev Container / Docker (Windows i Linux)

Najprostsza droga do jednakowego środowiska. Używamy gotowego obrazu:

`ghcr.io/simba-avionic/simba_avionics_dockers/latex_devcontainer:1.5.0`

(konfiguracja: [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json)).

#### Cursor / VS Code (zalecane)

1. Zainstaluj [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   (Windows: włącz WSL2 backend) albo Docker Engine (Linux).
2. Otwórz to repo w Cursor / VS Code.
3. Command Palette → **Dev Containers: Reopen in Container**
   (pierwsze uruchomienie ściąga obraz ~z GHCR).
4. W terminalu kontenera:

```bash
cd 1_SRD && make
cd ../2_CONOPS && make
cd ../4_TPTR && make
```

### Wydanie (tag → GitHub Release)

Workflow [`.github/workflows/release-docs.yml`](.github/workflows/release-docs.yml)
buduje wszystkie PDF-y przy pushu taga w formacie `vMAJOR.MINOR` (np. `v1.0`, `v1.1` —
**nie** `v1.1.1`) i tworzy GitHub Release
z assetami w formacie `Nazwa_wersja.pdf`:

- `Rurku_SRD_v1.0.pdf`
- `Rurku_CONOPS_v1.0.pdf`
- `Rurku_TPTR_v1.0.pdf`

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
cd ../4_TPTR && make
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
cd ..\4_TPTR
make
```

Jeśli `make` nie działa, w każdym folderze dokumentu:

```powershell
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build srd.tex
copy build\srd.pdf Rurku_SRD.pdf
```

(dla CONOPS: `conops.tex` → `Rurku_CONOPS.pdf`; dla TPTR: `tptr.tex` → `Rurku_TPTR.pdf`).

---

### Czyszczenie

```bash
cd 1_SRD && make clean
cd ../2_CONOPS && make clean
cd ../4_TPTR && make clean
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

## 3. System Architecture Document

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

- diagramy blokowe
- schemat przepływu paliwa
- schemat elektryczny wysokiego poziomu
- opis odpowiedzialności każdego podsystemu

**Kiedy aktualizować:** gdy dodajesz / usuwasz podsystem albo zmieniasz granice odpowiedzialności między nimi.

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
