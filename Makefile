all: pack

minify:  tmac.ono
pack:    tmac.ono.bytes

# Compress and optimise Mono for use in otroff (PDP-11/Unix v7)
tmac.ono: ono.tmac
	sed -f ./mutilate.sed $^ > $@

# Generate a pre-POSIX sh(1) script for copy+pasting into SIMH
tmac.ono.bytes: tmac.ono
	printf 'rm -f tmac.ono\n' > $@
	while IFS= read -r line; do \
		printf %s "$$line" \
		| od -b \
		| sed 's/^[0-7]* *//' \
		| dc -e '8i[c?z0<B]sA[plAx]sBlAx'; \
	done < $^ | fmt | sed 's/^/bytes >> tmac.ono /' >> $@
	chmod +x $@

# Wipe generated files
clean:
	rm -f tmac.ono
	rm -f tmac.ono.bytes

.PHONY: clean
