#!/bin/bash

test_assert_equals_with_integers() {
    (assert 1 equals 1)

    assert ${?} succeeded
}

test_assert_equals_with_integer_failing() {
    assert 1 equals 0 > assertion_output
    result=${?}
    rm .assertion_error # The test runner would think the test failed

    assertion_error=$(cat assertion_output)

    expected_error=$(cat <<-EXP
Expected: <0>
Got:      <1>
EXP
)
    assert ${result} failed
    assert "${assertion_error}" equals "${expected_error}"
}

test_assert_equals_with_strings_passing() {
    (assert "yes" equals "yes")

    assert ${?} succeeded
}

test_assert_equals_with_strings_failing() {
    assert "no" equals "yes" > assertion_output
    result=${?}
    _hide_assertion_failure_from_test_runner

    assertion_error=$(cat assertion_output)

    expected_error=$(cat <<-EXP
Expected: <yes>
Got:      <no>
EXP
)
    assert ${result} failed
    assert "${assertion_error}" equals "${expected_error}"
}

test_assert_multiworks_string_works() {
    (assert "yes but no" equals "yes but no")

    assert ${?} succeeded
}

test_assert_contains() {
    assert "hello world" contains "^hello world$"
    assert "hello world" contains "^hello"
    assert "hello world" contains "world$"
    assert "hello world" contains "w"
}

test_assert_contains_fails_with_proper_error_message() {
    assert "abc" contains "z$" > assertion_output
    result=${?}
    _hide_assertion_failure_from_test_runner

    assertion_error=$(cat assertion_output)

    expected_error=$(cat <<-EXP
Expected:         <abc>
To match pattern: <z$>
EXP
)
    assert ${result} failed
    assert "${assertion_error}" equals "${expected_error}"
}

_hide_assertion_failure_from_test_runner() {
    # The test runner would think the test failed
    rm .assertion_error
}