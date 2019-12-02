#!/bin/sh

rm -f /webapp/node_modules/*
for i in $(seq 0 10)
do
	touch /webapp/node_modules/fake-node-modules-$i
done
tail -f /dev/null
