.PHONY: install serve build check clean

# Install Ruby dependencies
install:
	bundle install

# Start Jekyll dev server with live reload — visit http://localhost:4000
serve:
	bundle exec jekyll serve --livereload --open-url

# Build the site (output in _site/)
build:
	bundle exec jekyll build

# Quick check before pushing: build + report any warnings/errors
check:
	@echo "--- Building site ---"
	bundle exec jekyll build 2>&1
	@echo ""
	@echo "--- Checking for broken internal links ---"
	@grep -rn "](projects/" _site/ 2>/dev/null | head -20 || true
	@echo ""
	@echo "--- Confidentiality check (should return nothing) ---"
	@grep -rn "Sanofi\|MSAT\|Ambarès\|OneAI\|Calypso\|Veeva Vault" projects/ README.md 2>/dev/null && echo "WARNING: confidential term found!" || echo "OK — no confidential terms found"
	@echo ""
	@echo "--- Done. Review output above before git push. ---"

# Remove generated files
clean:
	bundle exec jekyll clean
	rm -rf _site .jekyll-cache
