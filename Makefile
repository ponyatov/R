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
