.PHONY: all clean

BUILD := build
SRC := sad.tex
SECTIONS := $(wildcard sections/*.tex) config.tex
LOGO := ../common/simbalogo.png
PDF_NAME := Rurku_SAD.pdf
OUT := ./$(PDF_NAME)

all: $(OUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/sad.pdf: $(SRC) $(SECTIONS) $(LOGO) | $(BUILD)
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-outdir=$(BUILD) $(SRC)

$(OUT): $(BUILD)/sad.pdf
	cp -f $< $@

clean:
	latexmk -C -outdir=$(BUILD)
	rm -rf $(BUILD)
	rm -f $(OUT)
