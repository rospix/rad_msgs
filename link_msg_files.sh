#!/bin/bash

MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

# delete old links
cd "$MY_PATH"
for file in `find msg/*.msg -type l > /dev/null 2>&1 && find srv/*.srv -type l > /dev/null 2>&1`; do
  rm "$file"
done

# create new msg links
cd "$MY_PATH/msg"
for file in $(find **/*.msg -type f > /dev/null 2>&1); do
  ln -sf "$file" $(basename $file)
done

# create new srv links
cd "$MY_PATH/srv"
for file in $(find **/*.srv -type f > /dev/null 2>&1); do
  ln -sf "$file" $(basename $file)
done
