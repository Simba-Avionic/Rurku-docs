# Rurku-docs

Repozytorium dokumentacji projektu rakietowego. Tu trzymamy decyzje, wymagania i wyniki testów — żeby zespół nie polegał na pamięci i czacie.

## Jak z tego korzystać

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
