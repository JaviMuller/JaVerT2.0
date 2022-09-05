# Compile all js files in explode_tests/instrumented_auto to jsil

#! /bin/bash

number=`find ./explode_tests/instrumented_auto -name 'example-*.jsil' | wc -l`

for i in $(seq 0 $(($number - 1)))
do
	echo $i
	./cosette.native -file explode_tests/instrumented_auto/example-${i}.jsil -silent -out-mode=2
done