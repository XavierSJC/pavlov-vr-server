#!/bin/bash

StatsPath="/home/steam/pavlovserver/Pavlov/Saved/Stats/"

if [ -z $1 ]
then
	echo "USAGE: ExportPavlovShackStats.sh [endpoint] {path folder with json files}"
	exit
else
	if [[ $1 == *"/" ]]
	then
		endpoint=${1%?}
	else
		endpoint=$1
	fi
	echo "Using endpoint: '$endpoint'"
fi

if [ -z $2 ]
then
	echo "Extracting json files from $StatsPath"
else
	echo "Extracting json files from $2"
	StatsPath=$2
fi

if [ -d $StatsPath ]
then
	echo "Path '$($StatsPath)' is valid"
else
	echo "Folder does not exist $filesToExtract"
	exit
fi

OldStatsPath="$StatsPath/old"
if [ -d $OldStatsPath ]
then
	echo "Folder old alredy exist"
else
	mkdir $OldStatsPath
	echo "Created folder to archive stats exported"
fi

while true
do
	echo "Starting exporting"
	filesToExtract=$(find $StatsPath -maxdepth 1 -name '*.json')
	for file in $filesToExtract
	do
		filename=$(basename $file)

		echo "$(date +"%d/%b/%Y %H:%M:%S") Exporting file $filename"
		url=$endpoint/$filename

		postResult=$(curl -k -X POST \
		-s --write-out '%{http_code}' \
		-H "Content-Type: application/json" \
		--data @$file \
		"$url")
		
		if [[ $postResult == "201" ]]
		then
			echo -e "\tFile sent successfully"
			mv $file $OldStatsPath/$filename
		else
			echo -e "\tERROR in the POST operation to URL: $url"
			echo -e "\thttp_code: $postResult"
			if [[ $postResult == *"already exist"* ]]
			then
				echo -e "\tMatch already sent"
				mv $file $OldStatsPath/$filename
			elif [[ $postResult == *000* ]]
			then
				echo -e "\tCheck internet connection, this file will be exported again"
			elif [[ $postResult == *404* ]]
			then
				echo -e "\tCheck internet connection, this file will be exported again"
			else
				echo -e "\tUnnkown issue, renaming file to avoid new issues"
				mv $file $file.error
			fi
		fi
	done
	
	echo "Waiting for 15 minutes to next extraction"
	sleep 15m
done
