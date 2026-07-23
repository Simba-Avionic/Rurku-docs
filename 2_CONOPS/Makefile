.PHONY: all clean

BUILD := build
SRC := conops.tex
SECTIONS := $(wildcard sections/*.tex) config.tex
FIGURES := $(wildcard figures/*.*)
LOGO := ../common/simbalogo.png
PDF_NAME := Rurku_CONOPS.pdf
OUT := ./$(PDF_NAME)

all: $(OUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/conops.pdf: $(SRC) $(SECTIONS) $(FIGURES) $(LOGO) | $(BUILD)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-outdir=$(BUILD) $(SRC)

$(OUT): $(BUILD)/conops.pdf
	cp -f $< $@

clean:
	latexmk -C -outdir=$(BUILD)
	rm -rf $(BUILD)
	rm -f $(OUT)
