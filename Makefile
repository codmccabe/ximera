# Ximera Makefile for building PDF

.PHONY: all clean pdf html

# Directories
CHAPTERS_DIR := chapters
BUILD_DIR := build
HTML_DIR := html
PDF_DIR := $(BUILD_DIR)/pdf

# Find all .tex files in chapters directory
TEX_FILES := $(wildcard $(CHAPTERS_DIR)/*.tex)
PDF_FILES := $(patsubst $(CHAPTERS_DIR)/%.tex,$(PDF_DIR)/%.pdf,$(TEX_FILES))

# Default target
all: pdf copy-to-html

# Create directories
$(PDF_DIR):
	mkdir -p $(PDF_DIR)

$(HTML_DIR):
	mkdir -p $(HTML_DIR)

# Build PDF files
pdf: $(PDF_DIR) $(PDF_FILES)

$(PDF_DIR)/%.pdf: $(CHAPTERS_DIR)/%.tex
	pdflatex -interaction=nonstopmode -output-directory=$(PDF_DIR) $<
	pdflatex -interaction=nonstopmode -output-directory=$(PDF_DIR) $<

# Copy PDFs to html directory for GitHub Pages
copy-to-html: $(HTML_DIR) $(PDF_FILES)
	cp $(PDF_DIR)/*.pdf $(HTML_DIR)/

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR) $(HTML_DIR)
	find $(CHAPTERS_DIR) -name "*.aux" -delete
	find $(CHAPTERS_DIR) -name "*.log" -delete
	find $(CHAPTERS_DIR) -name "*.out" -delete
	find $(CHAPTERS_DIR) -name "*.toc" -delete