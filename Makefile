# Awesome-CV Resume Makefile
# Requires: XeLaTeX (via texlive-full, tectonic, or Overleaf)

RESUME = resume
PDF = $(RESUME).pdf

# Default target
all: $(PDF)

# Compile with Tectonic (recommended - auto-downloads packages)
tectonic: $(RESUME).tex
	tectonic -X compile $(RESUME).tex

# Compile with XeLaTeX (traditional method)
xelatex: $(RESUME).tex
	xelatex $(RESUME).tex
	xelatex $(RESUME).tex

# Use whichever compiler is available
$(PDF): $(RESUME).tex
	@if command -v tectonic >/dev/null 2>&1; then \
		echo "Compiling with Tectonic..."; \
		tectonic -X compile $(RESUME).tex; \
	elif command -v xelatex >/dev/null 2>&1; then \
		echo "Compiling with XeLaTeX..."; \
		xelatex $(RESUME).tex && xelatex $(RESUME).tex; \
	else \
		echo "ERROR: No LaTeX compiler found!"; \
		echo "Please install one of:"; \
		echo "  - Tectonic: https://tectonic-typesetting.github.io/"; \
		echo "  - TeX Live: sudo pacman -S texlive-core texlive-fontsextra"; \
		echo "Or use Overleaf: https://www.overleaf.com/"; \
		exit 1; \
	fi

# Open the PDF
view: $(PDF)
	xdg-open $(PDF)

# Clean build artifacts
clean:
	rm -f *.aux *.log *.out *.toc *.fdb_latexmk *.fls *.synctex.gz *.bcf *.run.xml *.blg *.bbl

# Clean everything including PDF
distclean: clean
	rm -f $(PDF)

# Install Tectonic on Arch Linux
install-tectonic:
	@echo "Installing Tectonic via pacman..."
	sudo pacman -S tectonic

# Install TeX Live on Arch Linux (larger, includes all packages)
install-texlive:
	@echo "Installing TeX Live (this will take a while)..."
	sudo pacman -S texlive-core texlive-fontsextra texlive-latexextra

.PHONY: all tectonic xelatex view clean distclean install-tectonic install-texlive
