#!/usr/bin/sed -f

#
# Produces an optimised version of Mono for use with SIMH-emulated otroff.
# Output is stripped of comments, whitespace, and regions of code specific
# to mandoc(1) or modern Troff implementations like Groff.
#
# Assumes POSIX basic regular expressions are in-use (sed(1) without `-E`).
#

1 {
	n
	a\
.\\" Generated from https://git.io/JimMJ by `mutilate.sed'
}

/[.'[:blank:]]\\"/ s/[[:blank:]]*\\".*//g
/^[.'][[:blank:]]/ s/[[:blank:]]\{1,\}//
/^[.'][[:blank:]]*$/ D

# Expand line continuations
/^[.'].*[^\\]\\$/ {
	N
	s/\\\n\([.']\{0,1\}\)[[:blank:]]*/\1/
}

# Ad hoc optimisations
/^[.'][[:blank:]]*el[[:blank:]]*/   s/[[:blank:]]\{1,\}/ /g
/^[.'][[:blank:]]*i[ef][[:blank:]]/ s/[[:blank:]]\{1,\}/ /g
/^[.'][[:blank:]]*[iel]\{2\}[[:blank:]]/ {
	s/^\(.\)[[:blank:]]*ie[[:blank:]]*/\1ie /
	s/^\(.\)[[:blank:]]*el[[:blank:]]*/\1el /
	s/^\(.\)[[:blank:]]*if[[:blank:]]*/\1if /
}

# Cull some unreachable code
/^[.']if '\\\*(\$0'mandoc' \\{\.de UL/, /^\.\\}$/ d
/^[.']if '\\\*(\$0'mandoc' \\{\.de 4@$/, /^\.rm 4@-mandoc$/ d
/^[.']rr 4@-mandoc-index$/, /^\.\\}$/ d
/^[.']if '\\\*(\$0'groff' \\{\.length \\\\\$1 \\\\\$2$/, /^\.\\}$/ d
