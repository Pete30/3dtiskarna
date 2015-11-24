SHELL := /bin/bash

# blender vars
BLENDER=/Applications/Blender-2.69-OSX_10.6-x86-64/blender.app/Contents/MacOS/blender
BLENDER_FILE=../i3_Berlin/Blender/i3\ Berlin.blend

# suffix replacement vars
ASCIIDOC_SUFF=asciidoc
DOCBOOK_SUFF=xml
TMP_SUFF=tmp
HUGO_HEADER_SUFF=hugo_head
MARKDOWN_SUFF=md
MARKDOWN_DIR=markdown


all: media optimize

media:
	mkdir media
	$(BLENDER) -S Section\ 1\ Single\ Parts -b $(BLENDER_FILE) -o "media/Section_1_###.png" -E BLENDER_RENDER -t 8 -F PNG -a
	$(BLENDER) -S Section\ 2\ Y-Unit -b $(BLENDER_FILE) -o "media/Section_2_###.png" -E BLENDER_RENDER -t 8 -F PNG -a
	$(BLENDER) -S Section\ 3\ XZ-Unit -b $(BLENDER_FILE) -o "media/Section_3_###.png" -E BLENDER_RENDER -t 8 -F PNG -a
	$(BLENDER) -S Section\ 4\ Wiring -b $(BLENDER_FILE) -o "media/Section_4_###.png" -E BLENDER_RENDER -t 8 -F PNG -a
	$(BLENDER) -S Section\ 5\ Calibration -b $(BLENDER_FILE) -o "media/Section_5_###.png" -E BLENDER_RENDER -t 8 -F PNG -a


markdown:
	mkdir markdown
	# convert asciidoc to docbook 
	for i in $$(ls S*); do asciidoc --backend=docbook --out-file markdown/$${i%.$(ASCIIDOC_SUFF)}.xml $$i ; done
	# convert docbook to strict markdown
	for i in $$(ls S*); do pandoc --chapter -f docbook -t markdown_github -o markdown/$${i%.$(ASCIIDOC_SUFF)}.tmp markdown/$${i%.$(ASCIIDOC_SUFF)}.xml && rm markdown/$${i%.$(ASCIIDOC_SUFF)}.xml ; done
	# fix image links and remove next link
	for i in $$(ls markdown/S*); do sed -e 's/staticmedia/media/g' -e 's/https:\/\/github.com\/open3dengineering\/i3_Berlin\/wiki/\/manual_i3_berlin/g' -e 's/manual_i3_berlin.*/\L&/g' -e 's/media/\/media/g' -e '/\[Next\]/d' -e '/\[Next/d' -e '/Section\]/d' < $$i > $${i%.$(TMP_SUFF)}.md && mv $${i%.$(TMP_SUFF)}.md $$i ; done
	# add hugo header
	./hugo_header.sh markdown tmp
	# fix tables
	for i in $$(ls markdown/S*); do perl -0pe 's/<col width="50%" \/>\n<col width="50%" \/>\n<tbody>\n<tr class="odd">\n<td align="left"/<col width="85%" \/>\n<col width="15%" \/>\n<tbody>\n<tr class="odd">\n<td align="left" rowspan="100"/g' $$i > $${i%.$(TMP_SUFF)}.md ; done
	# fix tables in bill of materials
	./bill_of_materials.pl markdown/Section-1.2-Tools-and-Parts.md
	# rm tmp files
	rm markdown/*.$(TMP_SUFF)
book: book.asc
	mkdir book
	find . \( ! -regex '.*/\..*' ! -regex '.*~' ! -name 'Makefile' ! -path './book/*' \) -type f -exec cp --parents '{}' 'book/' \;

book.asc: 
	rm -f book.asc
	for i in $$(ls S*); do echo "include::$$i[]" >> book.asc; done


CHECK_OPTIARG := $(shell which optipng 2>/dev/null)

optimize: media	 
ifdef CHECK_OPTIARG
	optipng media/*.png
else 
	@echo "Error: please install optipng ( apt-get install optipng )"
endif

clean:
	rm -fr media/

markdown-clean:
	rm -fr markdown
