#!/bin/bash

set -e

app_name="cumulonimbus-project"

# Remove the CUMULONIMBUS_FAIL_RUN check in real projects, its for testing.
if [ -n "$CUMULONIMBUS_FAIL_RUN" ]
then
	echo "Failure forced by CUMULONIMBUS_FAIL_RUN"
	exit 1
fi


# later call to pm2 list -name was stalling on first run, run pm2 list to warm things up
pm2 list

# recording existing PM2 ids so they can be removed 
old_ids=$(pm2 jlist | node -e "var pm2List = JSON.parse(require('fs').readFileSync('/dev/stdin').toString()); 
	pm2List.forEach(function(value) {
		if (value.name == '$app_name') {
			console.log(value.pm2_env.pm_id);
		}
	});
")

if pm2 start ./src/hello-server.js --name "$app_name"
then 
	for old_id in $old_ids
	do
		pm2 delete $old_id
	done
else
	echo "PM2 unable to start app"
	exit 1
fi


