#!/bin/bash

ORGS="
scale-tech
scale-av
"

LIST="repo-list"

LOCALREPOS='/home/git-repos'

for i in ${ORGS}; do
	mkdir -p ${LOCALREPOS}/${i}
	cd ${LOCALREPOS}/${i}
	if [ ! -d ${LIST} ]; then
		git clone https://github.com/${i}/${LIST}.git
	else
		cd ${LIST}
		git pull
		cd -
	fi
	for r in $(cat ${LIST}/repo-list | sed -e 's/\..*$//g' -e '/^[#;]/d'); do
		if [ ! -d ${r} ]; then
			git clone https://github.com/${i}/${r}.git
			echo "Created ${i}/${r}"
		else
			cd ${r}
			git pull
			cd -
			echo "Updated ${i}/${r}"
		fi
	done
done
