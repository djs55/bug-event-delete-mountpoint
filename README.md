To attempt to reproduce:
```
./go.sh
```

Example log (not currently showing the bug):
```
Building webapp
Step 1/4 : FROM alpine
 ---> 965ea09ff2eb
Step 2/4 : COPY entrypoint.sh /
 ---> Using cache
 ---> ab66ccdb8818
Step 3/4 : RUN chmod +x /entrypoint.sh
 ---> Using cache
 ---> 2013b08c40dc
Step 4/4 : ENTRYPOINT [ "/entrypoint.sh" ]
 ---> Using cache
 ---> 94e2ecac8ae4

Successfully built 94e2ecac8ae4
Successfully tagged compose_webapp:latest
Creating network "compose_default" with the default driver
Creating compose_webapp_1 ... 
[1A[2KCreating compose_webapp_1 ... [32mdone[0m[1BThe container should have a populated /webapp/node_modules directory:
total 4
     4 drwxr-xr-x    2 root     root          4096 Dec  2 21:02 .
     0 drwxr-xr-x    6 root     root           192 Dec  2 21:02 ..
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-0
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-1
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-10
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-2
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-3
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-4
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-5
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-6
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-7
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-8
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-9
The container should show 2 mountpoints:
osxfs on /webapp type fuse.osxfs (rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other,max_read=1048576)
/dev/sda1 on /webapp/node_modules type ext4 (rw,relatime)
Touching some_existing_file and new_file.
The container should see the 2 new files:
total 16
-rw-r--r--    1 root     root            95 Dec  2 21:00 Dockerfile
-rw-r--r--    1 root     root           136 Dec  2 21:00 entrypoint.sh
-rw-r--r--    1 root     root             0 Dec  2 21:02 new_file
drwxr-xr-x    2 root     root          4096 Dec  2 21:02 node_modules
-rw-r--r--    1 root     root            17 Dec  2 21:02 some_existing_file
Modifying some_existing_file on the host.
The container should see the modification:
modified
The container should still have a populated /webapp/node_modules directory:
total 4
     4 drwxr-xr-x    2 root     root          4096 Dec  2 21:02 .
     0 drwxr-xr-x    7 root     root           224 Dec  2 21:02 ..
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-0
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-1
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-10
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-2
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-3
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-4
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-5
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-6
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-7
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-8
     0 -rw-r--r--    1 root     root             0 Dec  2 21:02 fake-node-modules-9
The container should show 2 mountpoints:
osxfs on /webapp type fuse.osxfs (rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other,max_read=1048576)
/dev/sda1 on /webapp/node_modules type ext4 (rw,relatime)
Stopping compose_webapp_1 ... 
[1A[2KStopping compose_webapp_1 ... [32mdone[0m[1BRemoving compose_webapp_1 ... 
[1A[2KRemoving compose_webapp_1 ... [32mdone[0m[1BRemoving network compose_default
```
