#!/bin/sh


# Remove the CUMULONIMBUS_FAIL_PRERUN check in real projects, its for testing.
if ! [ -n $CUMULONIMBUS_FAIL_PRERUN ]
then
	echo "Failure forced by CUMULONIMBUS_FAIL_PRERUN"
	exit 1
fi
