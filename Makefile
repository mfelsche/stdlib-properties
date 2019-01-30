PONYC ?= ponyc
config ?= release
ifdef config
  ifeq (,$(filter $(config),debug release))
    $(error Unknown configuration "$(config)" Use either debug or release)
  endif
endif

ifeq ($(config),debug)
	PONYC_FLAGS += --debug
endif

PONYC_FLAGS += -o build/$(config)
BINARY = build/$(config)/stdlib-properties

test: $(BINARY)
	$(BINARY)

.deps:
	stable fetch

$(BINARY): .deps build stdlib-properties/*.pony
	stable env $(PONYC) stdlib-properties $(PONYC_FLAGS)

build:
	mkdir build

clean:
	rm -rf build

.PHONY: clean test
