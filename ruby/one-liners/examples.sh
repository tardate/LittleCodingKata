#!/bin/bash

echo "EXAMPLE: Regexp based filtering - should match /foo/a/"
printf '/foo/a/report.log\n/foo/y/power.log\n/foo/abc/errors.log' | ruby -ne 'print if /\/foo\/a\//'
