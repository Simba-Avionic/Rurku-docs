.PHONY: all clean

BUILD := build
SRC := srd.tex
SECTIONS := $(wildcard sections/*.tex) config.tex
LOGO := ../common/simbalogo.png
PDF_NAME := Rurku_SRD.pdf
OUT := ./$(PDF_NAME)

all: $(OUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/srd.pdf: $(SRC) $(SECTIONS) $(LOGO) | $(BUILD)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-outdir=$(BUILD) $(SRC)

$(OUT): $(BUILD)/srd.pdf
	cp -f $< $@

clean:
	latexmk -C -outdir=$(BUILD)
	rm -rf $(BUILD)
	rm -f $(OUT)
