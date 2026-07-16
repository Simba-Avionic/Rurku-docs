# 1_SRD

**System Requirements Document** template for the Rurku student liquid-rocket project.

Answers: **what are we building?** Measurable requirements that major design decisions must respect.

## Layout

| Path | Purpose |
| --- | --- |
| `srd.tex` | Main file (preamble + `\input`) |
| `config.tex` | Metadata + `\todo` macros |
| `sections/` | Section content |
| `figures/` | Diagrams if needed |
| `Makefile` | PDF build |

### Sections

| File | Topic |
| --- | --- |
| `00-frontmatter` | Title page, TOC, acronyms |
| `01-purpose` | Why this document exists |
| `02-context` | Stakeholders / owners |
| `03-scope` | In/out of scope, assumptions |
| `04-conventions` | ID scheme, priority, V&V methods |
| `05-mission-reqs` | Mission success requirements |
| `06-vehicle-reqs` | Vehicle system-level requirements |
| `07-subsystem-reqs` | Engine, Aerostructure, Avionics, Recovery, Simulations |
| `08-gse-reqs` | Ground Support Equipment |
| `09-safety-reqs` | Safety Musts |
| `10-verification` | How requirements are proven |
| `11-traceability` | Need → REQ → SAD allocation |
| `12-change-control` | When/how to change requirements |
| `13-appendices` | Appendices |
| `99-changelog` | Revision history |

## Getting started

1. Fill `config.tex`.
2. Lock mission numbers in `05-mission-reqs` first (apogee, mass, recovery, \ldots).
3. Cascade into vehicle / subsystem / GSE / safety tables.
4. `make` → `Rurku_SRD.pdf`; artifacts in `build/`.

Related docs: CONOPS (how ops run), SAD (architecture), Test Plan (how you verify).
