#!/bin/bash

set -x


.ninja-build/Sources/hc Tests/EndToEndTests/TestCases/Break.hylo --verbose

.ninja-build/Sources/hc Tests/EndToEndTests/TestCases/Break.hylo --verbose --emit llvm
cat StdLib.ll | grep -C 10 "atomic"
