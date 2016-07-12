#!/usr/bin/env bash

source functions.sh

for file in *.m4v
do
	convert "${file}" "${file}.small.m4v"
done

for file in *.avi
do
	convert "${file}" "${file}.m4v"
done
