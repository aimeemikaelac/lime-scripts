echo "Sending topology to Lime"
source sendTestTopologyToLime.sh
echo ""
sleep 2
echo "Creating OVX network"
source createTestNetwork.sh 128.138.189.249 128.138.189.140
echo ""
sleep 5
echo "Writing openflow rules"
source createRules.sh
echo -ne '.\r'
sleep 2
echo -ne '...\r'
sleep 2
echo -ne '.....\r'
sleep 2
echo -ne '.......\r'
sleep 2
echo -ne '.........\r'
sleep 2
echo "\nDone waiting"
echo "Initializing migration"
curl http://192.168.1.1:9000/startMigration
sleep 5
echo ""
echo "Finished initialization"
echo "Migrating ubuntu1"
source migrateUbuntu1.sh
echo ""
source ubuntu1Finished.sh
echo ""
echo "Finished migrating ubuntu1"
echo "Migrating ubuntu2"
source migrateUbuntu2.sh
echo ""
source ubuntu2Finished.sh
echo ""
echo "Finished migrating ubuntu2"
echo "Finishing migration"
curl 'http://192.168.1.1:9000/finishMigration/00:a4:23:05:00:00:00:01'
echo ""
echo "Finished running Lime"
