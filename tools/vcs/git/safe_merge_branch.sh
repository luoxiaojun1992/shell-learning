#! /bin/bash

workdir=$1
cd $workdir

sourceBranch=$2

currentBranch=`git branch --show-current`
echo "Merging $sourceBranch to $currentBranch"

echo "Updating $currentBranch"
git pull origin $currentBranch

echo "Creating backup branch"
backupBranchCnt=`git branch | grep "$currentBranch-bak" | wc -l`
newBackupBranchNum=$(($backupBranchCnt + 1))
newBackupBranchName="$currentBranch-bak-$newBackupBranchNum"
newBackBranchCnt=`git branch | grep $newBackupBranchName | wc -l`
if [ $newBackBranchCnt -gt 0 ]; then
	echo "New backup branch existed, please confirm!"
	exit 1
fi
git branch "$newBackupBranchName"

echo "Merging branch"
git pull origin $sourceBranch --no-ff

echo "Merged successfully"
