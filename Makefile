RM = rm -rf
LIB = lib
MINIMIZE = java -jar tools/yuicompressor-2.4.6.jar --nomunge --preserve-semi -o $(TARGET)/JSAV-min.js  $(TARGET)/JSAV.js 
CAT = cat
SRC = src
TARGET = build

# If I am a submodule, the FETCH_HEAD might be in the main module
if test -d .git; then FETCH = .git/FETCH_HEAD; \
 else FETCH = ../.git/modules/JSAV/FETCH_HEAD; fi;

SOURCES = $(SRC)/front.js $(SRC)/core.js $(SRC)/utils.js $(SRC)/anim.js $(SRC)/messages.js $(SRC)/effects.js $(SRC)/events.js $(SRC)/graphicals.js $(SRC)/datastructures.js $(SRC)/array.js $(SRC)/tree.js $(SRC)/list.js $(SRC)/code.js $(SRC)/settings.js $(SRC)/questions.js $(SRC)/exercise.js $(SRC)/version.js 

all: build

clean:
	$(RM) *~
	$(RM) build/*
	$(RM) examples/*~
	$(RM) src/*~ src/version.txt src/front.js src/version.js
	$(RM) css/*~

build: $(TARGET)/JSAV.js $(TARGET)/JSAV-min.js

$(TARGET)/JSAV.js: $(SRC)/version.txt $(SRC)/front.js $(SRC)/version.js $(SOURCES)
	-mkdir $(TARGET)
	$(CAT) $(SOURCES) > $(TARGET)/JSAV.js

$(FETCH):

$(SRC)/version.txt: $(FETCH)
	git describe --tags --long | awk '{ printf "%s", $$0 }' - > $(SRC)/version.txt

$(SRC)/front.js: $(SRC)/front1.txt $(SRC)/version.txt $(SRC)/front2.txt
	$(CAT) $(SRC)/front1.txt $(SRC)/version.txt $(SRC)/front2.txt > $(SRC)/front.js

$(SRC)/version.js :$(SRC)/version1.txt $(SRC)/version.txt $(SRC)/version2.txt
	$(CAT) $(SRC)/version1.txt $(SRC)/version.txt $(SRC)/version2.txt > $(SRC)/version.js

$(TARGET)/JSAV-min.js: $(SRC)/version.txt $(SRC)/front.js $(SRC)/version.js $(SOURCES)
	-$(MINIMIZE)
