USING: challenge.lib tools.test ;
IN: challenge.lib

! Example from spec
{ { 2 3 10 0 0 } } [ { 0 2 0 3 10 } 0 movNums ] unit-test

! Edge cases
{ { } } [ { } 0 movNums ] unit-test
{ { 1 2 3 } } [ { 1 2 3 } 0 movNums ] unit-test
{ { 0 0 0 } } [ { 0 0 0 } 0 movNums ] unit-test
{ { 5 } } [ { 5 } 0 movNums ] unit-test
{ { 0 } } [ { 0 } 0 movNums ] unit-test

! Other numbers
{ { 1 3 5 2 2 2 } } [ { 1 2 3 2 5 2 } 2 movNums ] unit-test
{ { 0 1 2 3 4 5 } } [ { 0 1 2 3 4 5 } 99 movNums ] unit-test
