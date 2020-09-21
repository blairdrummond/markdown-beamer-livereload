##
# DScD Pandoc Presentation
#
# @file
# @version 0.1
# @author Blair Drummond

PDF_NAME = presentation
WATCH = content.md

build: .build/titlepage.pdf .build/content.pdf
	pdfunite .build/titlepage.pdf .build/content.pdf $(PDF_NAME).pdf
	rm -rf .build

dev: $(WATCH)
	@echo "Watching content.md for changes"
	inotifywait -m $(WATCH) -e modify | while read path action file; do \
		make build; \
	done;

# Gitlab needs a static name
gitlab: build
	@cp $(PDF_NAME).pdf presentation-gitlab.pdf

template:
	cp -n .template/* .

.build/titlepage.pdf: content.md
	@echo Make the title page
	@mkdir -p .build
	pandoc -s -t beamer --template .DScD-titlepage.beamer -o .build/titlepage.pdf content.md

.build/content.pdf: content.md
	@echo Make the title page
	@mkdir -p .build
	pandoc -s -t beamer --template .DScD.beamer -o .build/content.pdf content.md

# end
