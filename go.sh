#!/bin/bash

rm -f webapp/new_file
mkdir -p webapp
echo initial-contents > webapp/some_existing_file

function finish {
  docker-compose down || true
}
trap finish EXIT

# Starting application
docker-compose up -d
sleep 1s # just in case

echo The container should have a populated /webapp/node_modules directory:
docker exec mounts2_webapp_1 ls -lsa /webapp/node_modules 

echo The container should show 2 mountpoints:
docker exec mounts2_webapp_1 mount | grep webapp

echo Touching some_existing_file and new_file.
touch ./webapp/some_existing_file
touch ./webapp/new_file

echo The container should see the 2 new files:
docker exec mounts2_webapp_1 ls -l /webapp

echo Modifying some_existing_file on the host.
echo modified > ./webapp/some_existing_file

echo The container should see the modification:
docker exec mounts2_webapp_1 cat /webapp/some_existing_file

echo The container should still have a populated /webapp/node_modules directory:
docker exec mounts2_webapp_1 ls -lsa ./webapp/node_modules

echo The container should show 2 mountpoints:
docker exec mounts2_webapp_1 mount | grep webapp
