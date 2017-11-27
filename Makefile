ECHO=
#SCHEMA=out/difdepo.rng
SCHEMA=/home/lou/Public/TEI/P5/Exemplars/tei_all.rng
#CORPUS=Corpus
#CORPUS=Final
CORPUS=Current
STYLES=fixes.xsl
CHECKUP=checkups.xsl
#STYLES=norm2ou.xsl
XSLHOME=/usr/share/xml/tei/stylesheet/profiles/oulipo/
CORPUSHDR=corpHeaderStart.txt
CURRENT=`pwd`

reform:
	for f in $(CORPUS)/*.xml ; do \
		echo $$f; \
		saxon $$f $(STYLES) > $(CORPUS2)/$$f; done;
checkUp:
	for f in $(CORPUS)/*.xml ; do \
		saxon $$f $(CHECKUP) >>checkup.lis; done;
convert:
	cd $(CORPUS); for f in *.docx ; do \
		echo $$f; \
		docxtotei $$f tmp/$$f.xml ; \
		saxon tmp/$$f.xml $(STYLES) >$$f.xml; done; cd $(CURRENT);

check:
	cd $(CORPUS); for f in *.xml ; do \
		echo $$f; \
		jing  $(SCHEMA) \
		$$f ; done; cd $(CURRENT);

driver:
	cp $(CORPUSHDR) $(CORPUS)_driver.tei;\
		for f in $(CORPUS)/*.xml ; do \
		echo "<xi:include href='$$f'/>" >> $(CORPUS)_driver.tei; \
	done; echo "</teiCorpus>" >> $(CORPUS)_driver.tei

schema: 
	teitorelaxng --odd difdepo.odd

updateXSL:
	cp from_common.xsl $(XSLHOME)

clean:
	cd $(CORPUS); rm *.xml
