#!/bin/bash

rm -f compose/webapp/new_file
mkdir -p compose/webapp
echo initial-contents > compose/webapp/some_existing_file

function finish {
	(cd compose && docker-compose down) || true
}
trap finish EXIT

# Starting application
(cd compose && docker-compose up -d)
sleep 1s # just in case

echo The container should have a populated /webapp/node_modules directory:
docker exec compose_webapp_1 ls -lsa /webapp/node_modules 

echo The container should show 2 mountpoints:
docker exec compose_webapp_1 mount | grep webapp

echo Touching some_existing_file and new_file.
touch ./compose/webapp/some_existing_file
touch ./compose/webapp/new_file

echo The container should see the 2 new files:
docker exec compose_webapp_1 ls -l /webapp

echo Modifying some_existing_file on the host.
echo modified > ./compose/webapp/some_existing_file

echo The container should see the modification:
docker exec compose_webapp_1 cat /webapp/some_existing_file

echo The container should still have a populated /webapp/node_modules directory:
docker exec compose_webapp_1 ls -lsa ./webapp/node_modules

echo The container should show 2 mountpoints:
docker exec compose_webapp_1 mount | grep webapp
