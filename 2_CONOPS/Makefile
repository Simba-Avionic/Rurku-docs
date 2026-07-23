.PHONY: all clean diff

BUILD := build
SRC := conops.tex
SECTIONS := $(wildcard sections/*.tex) config.tex
FIGURES := $(wildcard figures/*.*)
LOGO := ../common/simbalogo.png
PDF_NAME := Rurku_CONOPS.pdf
OUT := ./$(PDF_NAME)

DIFF_REF ?= master
DIFF_BUILD := $(BUILD)/diff
DIFF_DIR := ../diff_release
DIFF_OUT := $(DIFF_DIR)/$(PDF_NAME:.pdf=_diff.pdf)
DIFF_STYLE := ../common/latexdiff-style.tex

all: $(OUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/conops.pdf: $(SRC) $(SECTIONS) $(FIGURES) $(LOGO) | $(BUILD)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-outdir=$(BUILD) $(SRC)

$(OUT): $(BUILD)/conops.pdf
	cp -f $< $@

# PDF with changes vs DIFF_REF (default: master) highlighted via latexdiff
diff:
	@command -v latexdiff-vc >/dev/null || { \
		echo "Error: latexdiff-vc not found (install latexdiff)"; exit 1; }
	@git rev-parse --verify "$(DIFF_REF)^{commit}" >/dev/null || { \
		echo "Error: git ref '$(DIFF_REF)' not found"; exit 1; }
	rm -rf $(DIFF_BUILD)
	mkdir -p $(DIFF_BUILD) $(DIFF_DIR)
	latexdiff-vc --git --flatten -r "$(DIFF_REF)" --force --dir=$(DIFF_BUILD) $(SRC)
	cp -f $(DIFF_STYLE) $(DIFF_BUILD)/latexdiff-style.tex
	perl -i -0pe 's|(\\begin\{document\})|\\input{$(DIFF_BUILD)/latexdiff-style.tex}\n$$1|s' \
		$(DIFF_BUILD)/$(SRC)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-outdir=$(DIFF_BUILD) $(DIFF_BUILD)/$(SRC)
	cp -f $(DIFF_BUILD)/$(basename $(SRC)).pdf $(DIFF_OUT)
	@echo "Wrote $(DIFF_OUT) (diff vs $(DIFF_REF))"

clean:
	latexmk -C -outdir=$(BUILD)
	rm -rf $(BUILD) $(basename $(SRC))-difforigin
	rm -f $(OUT)
