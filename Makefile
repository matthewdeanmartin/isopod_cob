
make_docs:
    coboldoc generate *.cob --output docs

compile:
	./compile_cob.sh

install_unit_tester:
    cobc -x -debug modules/gcblunit/gcblunit.cbl --job=-h

test:
    cobc -x -debug sample_test.cob