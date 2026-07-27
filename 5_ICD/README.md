# 5_ICD

**Interface Control Document** template for the Rurku student liquid-rocket project.

Answers: **how exactly do the blocks connect?** Controlled definition of each
primary interface (mechanical, fluid, electrical, data, HW/SW) — not the
subsystem map (SAD) and not pad procedures (CONOPS).

## Layout

| Path | Purpose |
| --- | --- |
| `icd.tex` | Main file (preamble + `\input`) |
| `config.tex` | Metadata + `\todo` macros |
| `sections/` | Intro, conventions, register, change control |
| `interfaces/` | One `.tex` file per `IF-*` record |
| `figures/` | Pinouts, connector drawings, message diagrams |
| `Makefile` | PDF build → `Rurku_ICD.pdf` |

### Sections

| File | Topic |
| --- | --- |
| `00-frontmatter` | Title page, TOC, acronyms |
| `01-purpose` | Why this document exists |
| `02-context` | Owners / readers |
| `03-scope` | In/out vs SAD / SRD / CONOPS / TPTR |
| `04-conventions` | IF IDs, interface types, field meanings |
| `05-register` | Master index (aligned with SAD) |
| `06-record-guide` | How to fill an IF sheet |
| `10-change-control` | How interface changes are approved |
| `11-appendices` | Appendices |
| `99-changelog` | Document revision history |

## Workflow

1. Keep the **register** in sync with SAD `IF-*` rows.
2. Copy `interfaces/IF-XXX-000.tex` → `interfaces/IF-0NN.tex`.
3. Fill both sides of the interface (owners must agree).
4. `\input{interfaces/IF-0NN}` in `icd.tex`.
5. Update register status + SAD ICD column.
6. `make`

## Starter records

| ID | Intent |
| --- | --- |
| `IF-001` | AVIONICS ↔ GSE high-speed link |
| `IF-002` | AVIONICS ↔ GSE low-speed link |
| `IF-003` | AVIONICS → PROP servo motor control |
| `IF-004` | AVIONICS ↔ PROP pressure sensor |
| `IF-005` | AVIONICS ↔ PROP temperature sensor |
| `IF-006` | AVIONICS → PROP igniter channel |
| `IF-007` | AVIONICS ↔ STRUCTURE engine connectors |
| `IF-008` | AVIONICS ↔ STRUCTURE safety pins |
| `IF-009` | GSE → AVIONICS charging control |
| `IF-XXX-000` | Blank template |

Related: SAD (register / architecture), SRD (requirements), TPTR (integration tests).
