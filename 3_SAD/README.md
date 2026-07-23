# 3_SAD

**System Architecture Document** template for the Rurku student liquid-rocket project.

Answers: **how is the system split?** Subsystem map, diagrams, ownership boundaries,
budgets, and interface pointers — not requirements and not pad procedures.

## Layout

| Path | Purpose |
| --- | --- |
| `sad.tex` | Main file (preamble + `\input`) |
| `config.tex` | Metadata + `\todo` macros |
| `sections/` | Section content |
| `figures/` | Block diagrams, P\&ID, electrical sketches |
| `Makefile` | PDF build → `Rurku_SAD.pdf` |

### Sections

| File | Topic |
| --- | --- |
| `00-frontmatter` | Title page, TOC, acronyms |
| `01-purpose` | Why this document exists |
| `02-context` | Owners / readers |
| `03-scope` | In/out vs SRD / CONOPS / TPTR / ICD |
| `04-conventions` | Block IDs, figure naming |
| `05-system-overview` | Top-level breakdown + context diagram |
| `06-propulsion-fluids` | Engine, tanks, feed, fluid schematic |
| `07-structures-recovery` | Airframe, mounts, recovery packaging |
| `08-avionics-electrical` | Avionics blocks, power / data |
| `09-gse` | Ground architecture |
| `10-interfaces` | Interface summary (until ICD exists) |
| `11-budgets` | Mass / power / volume |
| `12-srd-allocation` | REQ → architecture block |
| `13-appendices` | Appendices |
| `99-changelog` | Revision history |

## Getting started

1. Fill `config.tex`.
2. Lock the subsystem tree in `05-system-overview` (owners + boundaries).
3. Drop figures into `figures/` (block diagram, fluid schematic, electrical overview).
4. Fill budgets and interface pointers; keep pinouts / protocols for ICD later.
5. `make` → `Rurku_SAD.pdf`; artifacts in `build/`.

## Do not put here

| Content | Lives in |
| --- | --- |
| Measurable Must / Should requirements | SRD |
| Campaign timelines, pad roles, abort scripts | CONOPS |
| Test procedures, plots, pass/fail evidence | TPTR |
| Detailed connector pinouts / protocol ICDs | ICD (planned) |

Related: SRD (what), CONOPS (ops day), TPTR (prove / learn).
