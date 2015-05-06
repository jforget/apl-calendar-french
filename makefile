all: calendar-french.apl calendar-french.en.html calendar-french.fr.html

calendar-french.apl: calendar-french.apl-1 feasts testapl testapl1 merge-scripts
	./merge-scripts

calendar-french.apl-1: calendar-french.hpweb
	./genere-hpweb calendar-french

calendar-french.fr.html: calendar-french.hpweb
	./genere-hpweb calendar-french

calendar-french.en.html: calendar-french.hpweb
	./genere-hpweb calendar-french

