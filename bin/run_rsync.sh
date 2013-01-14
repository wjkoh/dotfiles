#!/usr/bin/env bash

ID=doyubkim

while true; do
        #rsync -avPhz --stats $ID@ssh.intel-research.net:/homes/$ID . | tee rsync_log.txt
        rsync -avPhz --stats -e "ssh $ID@ssh.intel-research.net ssh" ilsnb02:/homes/$ID/N7_rahul/cloth_files.tar . | tee rsync_log.txt
        #rsync -avPhz --stats -e "ssh $ID@ssh.intel-research.net ssh" ilsnb02:/homes/$ID/N7_rahul/karate_snu_report . --exclude '*.graph' --exclude '*.gv' --exclude 'pca.matrix_?' | tee rsync_log.txt
        sleep 1
done
