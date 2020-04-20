CWD    = $(CURDIR)
MODULE = $(notdir $(CWD))

NOW = $(shell date +%d%m%y)
REL = $(shell git rev-parse --short=4 HEAD)

.PHONY: all rust
all: rust

rust: target/debug/$(MODULE) $(MODULE).ini
	$^

target/debug/$(MODULE): src/*.rs Cargo.toml Makefile
	cargo build && size $@ && ldd $@

.PHONY: master shadow release zip

MERGE  = Makefile README.md .gitignore .vscode
MERGE += src Cargo.toml $(MODULE).*

master:
	git checkout $@
	git checkout shadow -- $(MERGE)

shadow:
	git checkout $@

release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	git checkout shadow
