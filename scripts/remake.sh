./cleanup.sh
cd ..
make
./scripts/setup_environment.sh
cd environment/explode_tests/instrumented
make clean
cd ../..