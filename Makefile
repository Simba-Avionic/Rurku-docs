DOCUMENTS := 1_SRD 2_CONOPS 4_TPTR

.PHONY: all clean $(DOCUMENTS)

all: $(DOCUMENTS)

$(DOCUMENTS):
	$(MAKE) -C $@ all

clean:
	for dir in $(DOCUMENTS); do \
		$(MAKE) -C $$dir clean; \
	done

release: all
	@if [ -z "$(VERSION)" ]; then \
		echo "Błąd: Musisz podać wersję, np. podając 'make release VERSION=1.0.0'"; \
		exit 1; \
	fi
	mkdir -p release
	for dir in $(DOCUMENTS); do \
		sub_name=$$(echo $$dir | sed 's/[0-9]_//'); \
		cp "$$dir/Rurku_$${sub_name}.pdf" "release/Rurku_$${sub_name}_$(VERSION).pdf"; \
	done
	ls -la release/