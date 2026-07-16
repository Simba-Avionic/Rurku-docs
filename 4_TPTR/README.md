# 4_TPTR

**Test Plan + Test Report** template for the Rurku student liquid-rocket project.

Answers: **what do we check, and what did we learn?**  
Plan and report are **one process** — not two loose files.

## Layout

| Path | Purpose |
| --- | --- |
| `tptr.tex` | Main file |
| `config.tex` | Metadata + authors |
| `sections/` | Intro, register, conventions, coverage |
| `records/` | One `.tex` file per test (Plan + Report) |
| `Makefile` | PDF build → `Rurku_TPTR.pdf` |

## Workflow

1. Add a row to the **test register** (`sections/04-test-register.tex`).
2. Copy `records/TP-XX-000.tex` → `records/TP-…​.tex`.
3. Fill **Plan** before the test; **Report** after.
4. `\input{records/TP-…}` in `tptr.tex`.
5. Update register status + SRD coverage table.
6. `make`

## Starter records

| ID | Intent |
| --- | --- |
| `TP-CF-001` | Cold-flow |
| `TP-SF-001` | Static fire |
| `TP-DR-001` | Countdown dry run |
| `TP-FL-001` | Flight |
| `TP-XX-000` | Blank template |

Related: SRD (requirements / V&V), CONOPS (ops stages and procedures).
