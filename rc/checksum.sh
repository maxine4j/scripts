#!/bin/bash

function verify-sha256 {
  EXPECTED_HASH=$1
  FILE_PATH=$2

  ACTUAL_HASH=$(shasum -a 256 $2 | awk '{print $1}')

  if [[ "$ACTUAL_HASH" == "$EXPECTED_HASH" ]]; then
    echo "✅ Actual matches expected"
    echo $ACTUAL_HASH
    return 0
  fi

  echo "❌ Actual DOES NOT match expected"
  diff <(echo "$EXPECTED_HASH" ) <(echo "$ACTUAL_HASH")
  return 1  
}

