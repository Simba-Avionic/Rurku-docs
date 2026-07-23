DOCUMENTS := 1_SRD 2_CONOPS 3_SAD 4_TPTR 5_ICD

DIFF_REF ?= master

.PHONY: all clean release diff $(DOCUMENTS)

all: $(DOCUMENTS)

$(DOCUMENTS):
	$(MAKE) -C $@ all

clean:
	for dir in $(DOCUMENTS); do \
		$(MAKE) -C $$dir clean; \
	done
	rm -rf release diff_release

diff:
	mkdir -p diff_release
	for dir in $(DOCUMENTS); do \
		$(MAKE) -C $$dir diff DIFF_REF="$(DIFF_REF)"; \
	done
	ls -la diff_release/

release: all
	@if [ -z "$(VERSION)" ]; then \
		echo "Błąd: Musisz podać wersję, np. 'make release VERSION=v1.0'"; \
		exit 1; \
	fi
	mkdir -p release
	for dir in $(DOCUMENTS); do \
		sub_name=$$(echo $$dir | sed 's/[0-9]_//'); \
		cp "$$dir/Rurku_$${sub_name}.pdf" "release/Rurku_$${sub_name}_$(VERSION).pdf"; \
	done
	ls -la release/
