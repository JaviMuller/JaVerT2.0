JS2JSILPREFLAGS = -file
JS2JSILPOSTFLAGS = -cosette
TARGETS = $(patsubst %.js, %.jsil, $(wildcard *.js))

all: $(TARGETS)


%.jsil: %.js
	../../js2jsil.native $(JS2JSILPREFLAGS) $< $(JS2JSILPOSTFLAGS)
	rm *.log

clean:
	rm *.jsil