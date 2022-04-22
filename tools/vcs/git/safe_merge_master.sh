#! /bin/bash

workdir=$1
cd $workdir

currentBranch=`git branch --show-current`
echo "Merging master to $currentBranch"

echo "Updateing $currentBranch"
git pull origin $currentBranch

echo "Creating backup branch"
backupBranchExisted=`git branch | grep "$currentBranch-bak" | wc -l`
if [ $backupBranchExisted -gt 0 ]; then
	echo 'Backup branch existed, please confirm!'
	exit 1
fi
git branch "$currentBranch-bak"

echo "Merging branch"
git pull origin master --no-ff

echo "Merged successfully"