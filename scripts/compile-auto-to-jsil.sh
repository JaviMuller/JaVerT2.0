# Compile all js files in explode_tests/instrumented_auto to jsil

#! /bin/bash

number=`find ./explode_tests/instrumented_auto -name 'example-*.js' | wc -l`

for i in $(seq 0 $(($number - 1)))
do
	echo $i
	./js2jsil.native -file explode_tests/instrumented_auto/example-${i}.js -cosette
done