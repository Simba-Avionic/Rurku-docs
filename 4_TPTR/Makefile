.PHONY: all clean

BUILD := build
SRC := tptr.tex
SECTIONS := $(wildcard sections/*.tex) $(wildcard records/*.tex) config.tex
FIGURES := $(wildcard figures/*.*) \
	$(wildcard images/*.*) $(wildcard images/*/*.*)
LOGO := ../common/simbalogo.png
PDF_NAME := Rurku_TPTR.pdf
OUT := ./$(PDF_NAME)

all: $(OUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/tptr.pdf: $(SRC) $(SECTIONS) $(FIGURES) $(LOGO) | $(BUILD)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-outdir=$(BUILD) $(SRC)

$(OUT): $(BUILD)/tptr.pdf
	cp -f $< $@

clean:
	latexmk -C -outdir=$(BUILD)
	rm -rf $(BUILD)
	rm -f $(OUT)
