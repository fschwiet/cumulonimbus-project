#!/bin/sh

# Remove the CUMULONIMBUS_FAIL_RUN check in real projects, its for testing.
if [ -n "$CUMULONIMBUS_FAIL_RUN" ]
then
	echo "Failure forced by CUMULONIMBUS_FAIL_RUN"
	exit 1
fi


#laster call to pm2 list -name was stalling on first run)
pm2 list

# recording existing PM2 ids so they can be removed 
id_selector="^pm2\s*id\s*:\s*\([0-9]*\)\s*$"
old_ids=$(pm2 list -name hello-server | grep $id_selector | sed "s/$id_selector/\1/")

if pm2 start ./src/hello-server.js --name hello-server
then 
	for old_id in $old_ids
	do
		pm2 delete $old_id
	done
else
	echo "PM2 unable to start app"
	exit 1
fi


