# 2_CONOPS

**Concept of Operations** template for the Rurku student liquid-rocket project.

Covers the full campaign: **cold-flow → static fire → packing → on-site days → flight**.

## Layout

| Path | Purpose |
| --- | --- |
| `conops.tex` | Main file (preamble + `\input`) |
| `config.tex` | Campaign metadata + `\todo` macros |
| `sections/` | Section content |
| `figures/` | Diagrams / zone maps |
| `Makefile` | PDF build |

### Sections

| File | Topic |
| --- | --- |
| `00-frontmatter` | Title page, TOC, acronyms |
| `01-purpose` | Campaign goal, success criteria |
| `02-system` | Vehicle + GSE + owners |
| `03-roles` | Pad roles |
| `04-constraints` | Scope, limits, go/no-go |
| `05-campaign` | Stage map and dependencies |
| `06-coldflow` | Cold-flow |
| `07-staticfire` | Static fire |
| `08-packing` | Competition packing |
| `09-onsite` | Day-by-day on-site plan |
| `10-modes` | Cold/hot/armed/\ldots modes |
| `11-flight-nominal` | Flight-day step scenario |
| `12-contingencies` | HOLD / abort / misfire /\ldots |
| `13-safety` | Pad safety |
| `14-risks` | Operational risks |
| `15-documentation` | SRD / SAD / Test Plan |
| `16-appendices` | Appendices |
| `99-changelog` | Revision history |

## Getting started

1. Fill in `config.tex`.
2. Start with `05-campaign`, then cold-flow / SF / packing / on-site.
3. `make` → PDF (`PDF_NAME` in the Makefile); build artifacts in `build/`.
