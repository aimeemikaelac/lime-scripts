echo "Sending topology to Lime"
source sendTestTopologyToLime.sh
echo ""
sleep 2
echo "Creating OVX network"
source createTestNetwork.sh 128.138.189.249 128.138.189.140
echo ""
sleep 10
echo "Writing openflow rules"
#ip forward rules on br1 - 00:a4:23:05:00:00:00:01
createIPMatchRule.sh "192.168.3.11" "3" "00:a4:23:05:00:00:00:01"
createIPMatchRule.sh "192.168.3.12" "4" "00:a4:23:05:00:00:00:01"
createIPMatchRule.sh "192.168.3.13" "5" "00:a4:23:05:00:00:00:01"
createIPMatchRule.sh "192.168.3.14" "2" "00:a4:23:05:00:00:00:01"
createIPMatchRule.sh "192.168.3.15" "2" "00:a4:23:05:00:00:00:01"
#ip forward rules on br2 - 00:a4:23:05:00:00:00:02
createIPMatchRule.sh "192.168.3.11" "2" "00:a4:23:05:00:00:00:02"
createIPMatchRule.sh "192.168.3.12" "2" "00:a4:23:05:00:00:00:02"
createIPMatchRule.sh "192.168.3.13" "2" "00:a4:23:05:00:00:00:02"
createIPMatchRule.sh "192.168.3.14" "3" "00:a4:23:05:00:00:00:02"
createIPMatchRule.sh "192.168.3.15" "3" "00:a4:23:05:00:00:00:02"
#ip forward rules on br3 - 00:a4:23:05:00:00:00:03
createIPMatchRule.sh "192.168.3.11" "2" "00:a4:23:05:00:00:00:03"
createIPMatchRule.sh "192.168.3.12" "2" "00:a4:23:05:00:00:00:03"
createIPMatchRule.sh "192.168.3.13" "2" "00:a4:23:05:00:00:00:03"
createIPMatchRule.sh "192.168.3.14" "3" "00:a4:23:05:00:00:00:03"
createIPMatchRule.sh "192.168.3.15" "4" "00:a4:23:05:00:00:00:03"

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
for i in `seq 1 5`;
do
	echo "Migrating ubuntu$i"
	source "migrateUbuntu$i.sh"
	echo ""
	finishedScriptPrefix="ubuntu$i"
	finishedScriptEnd="Finished.sh"
	source "$finishedScriptPrefix$finishedScriptEnd"
	echo ""
	echo "Finished migrating ubuntu$i"
done
#echo "Migrating ubuntu2"
#source migrateUbuntu2.sh
#echo ""
#source ubuntu2Finished.sh
#echo ""
#echo "Finished migrating ubuntu2"
echo "Finishing migration"
curl 'http://192.168.1.1:9000/finishMigration/00:a4:23:05:00:00:00:01'
echo ""
echo "Finished running Lime"
