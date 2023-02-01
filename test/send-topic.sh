#!/bin/bash

for VARIABLE in 1 .. 100
do
  http --quiet POST localhost:4151/pub\?topic=topic1 message=hello
  # http --quiet POST localhost:4153/pub\?topic=topic1 message=hello
done

