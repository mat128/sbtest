SBTEST: Simple Bash Tests
=========================

Simple library for bash script unit testing with mocks and asserts

Project structure
-----------------
Place your source files in a src/ folder and tests in a test/ folder
with filenames starting by "test_".  Runner can be invoked with

    ./sbtest.sh

in the base directory

Writing your first test
-----------------------

[examples/1-simple-test](examples/1-simple-test)

add.sh

    echo $(($1 + $2))

test 

    test_addition() {
    
        result=$(bash ./add.sh 2 2)
    
        assert_int ${result} 4
    }

Using mocks
-----------

[examples/2-mocking](examples/2-mocking)

clean.sh

    rm somewhere/$1

test

    test_clean_works() {
        mock rm --with-args "somewhere/some-file" --and exitcode 0
    
        bash ./clean.sh some-file
    
        assert_int $? 0
    }
    
