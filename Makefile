SOELIM = soelim
SED    = sed -f

OBJ   = tmac/ono.tmac
SRC   = tmac/ono.tmac-u


all: $(OBJ)


# Bundle a compressed macro package
$(OBJ): $(SRC)
	$(SOELIM) -rI $(PWD)/tmac $^ | $(SED) pack-macros.sed > $@


# Wipe generated artefacts and build targets
clean:
	rm -f $(OBJ)

.PHONY: clean
