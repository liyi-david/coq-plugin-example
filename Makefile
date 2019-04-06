COQ_MAKEFILE	= coq_makefile

default: Makefile.coq
	make -f $<

Makefile.coq : _CoqProject
	$(COQ_MAKEFILE) -f $< -o $@

install: Makefile.coq
	make -f $<
	make -f $< install

.merlin: Makefile.coq
	make -f $< .merlin

clean: Makefile.coq
	make -f Makefile.coq clean
	rm Makefile.coq
	rm Makefile.coq.conf
	rm theory/.*.aux
