# Shared latexdiff options (include from document Makefiles).
# Word-level diffs inside xltabular/tabularx/booktabs insert \DIF* before
# \toprule/\midrule and cause "Misplaced \noalign". Treat those envs as
# atomic units (like figures), then sanitize as a safety net.
LATEXDIFF_OPTS ?= --graphics-markup=none \
	--config=PICTUREENV='(?:picture|DIFnomarkup|tabularx|xltabular|longtable|reqtabular)[\w\d*@]*'

LATEXDIFF_SANITIZE := perl ../common/latexdiff-sanitize.pl
