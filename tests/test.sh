#!/bin/bash
echo "Running tests on $(hostname)"

if [ -f app/app.sh ]; then
  echo "TEST PASSED"
  exit 0
else
  echo "TEST FAILED"
  exit 1
fi
