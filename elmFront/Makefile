default: elm.js

ELM_FILES = $(shell find . -path ./elm-stuff -prune -o -path ./lib -prune -o -type f -name "*.elm" | grep "\.elm" | grep -v "examples" | grep -v "Test")

elm.js: $(ELM_FILES)
	elm-make --warn --yes $(ELM_FILES) --output ../myserver/static/js/elm.js

clean-deps:
	rm -rf elm-stuff

clean:
	rm -f *.js
	rm -rf elm-stuff/build-artifacts
