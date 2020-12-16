#!/bin/sh

test_description='indentation-aware function identification'
. ./test-lib.sh

t() {
	label=$1
	file=$2
	test_expect_success "$label" "
		echo '*.py	diff=python' >.gitattributes &&
		cp '$TEST_DIRECTORY/t4069/${file}_initial.py' '$TRASH_DIRECTORY/test.py' &&
		git add test.py &&
		git commit -m initial &&
		cp '$TEST_DIRECTORY/t4069/${file}_final.py' '$TRASH_DIRECTORY/test.py' &&
		git diff --function-context >result &&
		git diff --function-context >'$TEST_DIRECTORY/output_$file' &&
		test_cmp '$TEST_DIRECTORY/t4069/${file}_diff' result
	"
}

t 'Basic' 01
t 'Padding lines are empty' 02
t 'Padding lines are spaces' 03
t 'Indentation reduced by non-function lines' 04

test_done
