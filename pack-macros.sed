/^[.'][[:blank:]]*\\"/d
/^[.'][[:blank:]]*$/d

:X
/\\$/ {
	N
	s/\\\n//g
	:bX
}

s/^\([.']\)[[:blank:]]*\(i[ef]\)[[:blank:]]{1,}/\1\2 /g
s/^\([.']\)[[:blank:]]*el[[:blank:]]*/\1el /g
