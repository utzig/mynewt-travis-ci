#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# Ensure newt generates the expected intermediate representation of each
# target.
status=0
for i in ../answers/*
do
    target="$(basename $i)"
    target="${target%.json}"

    printf "Checking target \"$target\"\n"
    newt target dump "$target" > tmp.txt
    diff  --strip-trailing-cr "$i" tmp.txt
    rc="$?"

    # Remember failure.
    if [ "$rc" -ne 0 ]
    then
        echo "rc=$rc"
        status="$rc"
    fi
done

exit "$status"
