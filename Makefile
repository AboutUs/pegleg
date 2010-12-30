CFLAGS = -g -Wall $(OFLAGS) $(XFLAGS)
OFLAGS = -O3 -DNDEBUG
#OFLAGS = -pg

OBJS = tree.o compile.o
RT = preamble.rth header.rth footer.rth

all : peg leg

peg : peg.o $(OBJS)
	$(CC) $(CFLAGS) -o $@-new peg.o $(OBJS)
	mv $@-new $@

leg : leg.o $(OBJS)
	$(CC) $(CFLAGS) -o $@-new leg.o $(OBJS)
	mv $@-new $@

ROOT	=
PREFIX	= /usr/local
BINDIR	= $(ROOT)$(PREFIX)/bin

install : $(BINDIR)/peg $(BINDIR)/leg

$(BINDIR)/% : %
	cp -p $< $@
	strip $@

uninstall : .FORCE
	rm -f $(BINDIR)/peg
	rm -f $(BINDIR)/leg

peg.o : peg.c peg.peg-c

%.peg-c : %.peg
#	./peg -o $@ $<

leg.o : leg.c

leg.c : leg.leg
	./leg -o $@ $<

compile.o : compile.c $(RT)

%.rth : %.rtc
	perl escape.pl $* < $< > $@

check : peg .FORCE
	./peg < peg.peg > peg.out
	diff peg.peg-c peg.out
	rm peg.out

test examples : .FORCE
	$(SHELL) -ec '(cd examples;  $(MAKE))'

clean : .FORCE
	rm -f *~ *.o *.peg.[cd] *.leg.[cd] *.rth
	$(SHELL) -ec '(cd examples;  $(MAKE) $@)'

spotless : clean .FORCE
	rm -f peg
	rm -f leg
	$(SHELL) -ec '(cd examples;  $(MAKE) $@)'

.FORCE :
