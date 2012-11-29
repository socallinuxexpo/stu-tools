#!/bin/bash
#############################################################################
#
#       Copyright 2005 Stuart Sheldon (ACTUSA).
#
#       This software may be used and distributed according to the terms
#       of the GNU General Public License, incorporated herein by reference.
#
#       http://www.gnu.org/licenses/gpl.txt
#
#       This software comes as is, with no warranties what so ever. Use
#       this software at your own risk!
#
#       To contact the author, please send email to: support-AT-actusa.net
#
#############################################################################

BUSER="user"
PASS="password"
BUDIR="/home/mysqlback"
DBNAME=$(mysql -u ${BUSER} --password=${PASS} --disable-column-names \
	--exec='SHOW DATABASES')
echo "Begin MySql Backup."
echo "Reseting Update Logs."
mysql -u ${BUSER} --password=${PASS} --exec='FLUSH LOGS'
sleep 5
for i in ${DBNAME}; do
	if [ ${i} != information_schema ]; then
		echo "Backing up ${i}."
		mysqldump --opt -u ${BUSER} --password=${PASS} ${i} \
			> ${BUDIR}/${i}.sql
	else
		echo "Backing up ${i}."
		mysqldump --opt --skip-lock-tables \
			--skip-add-locks -u ${BUSER} \
			--password=${PASS} ${i} > ${BUDIR}/${i}.sql
	fi
done
echo "MySql Backup Done."
