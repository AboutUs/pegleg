#!/usr/bin/perl
print "static char *$ARGV[0]= \"\\\n";
for (<STDIN>) {
    s/"/\\"/g;
    s/\\\\/\\\\\\\\/g;
    s/\\0/\\\\0/g;
    s/\\n/\\\\n/g;
    s/\\$/\\\\/;
    s/$/\\n\\/;
    print;
}
print "\";\n";