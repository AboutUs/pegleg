#!/usr/bin/perl -n

# one-time conversion to unescaped c. test with ...
#    perl unescape.pl <header.rth | ./escape.pl header > xx; diff header.rth xx

s/\\n\\$//;
s/\\\\$/\\/;
s/\\\\n/\\n/g;
s/\\\\0/\\0/g;
s/\\\\\\\\/\\\\/g;
s/\\"/"/g;
next if /^";$/;
next if /^static char \*([a-z]+)= "\\$/;
print;