.PHONY: all clean

BUILD := build
SRC := icd.tex
SECTIONS := $(wildcard sections/*.tex) $(wildcard interfaces/*.tex) config.tex
LOGO := ../common/simbalogo.png
PDF_NAME := Rurku_ICD.pdf
OUT := ./$(PDF_NAME)

all: $(OUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/icd.pdf: $(SRC) $(SECTIONS) $(LOGO) | $(BUILD)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-outdir=$(BUILD) $(SRC)

$(OUT): $(BUILD)/icd.pdf
	cp -f $< $@

clean:
	latexmk -C -outdir=$(BUILD)
	rm -rf $(BUILD)
	rm -f $(OUT)
