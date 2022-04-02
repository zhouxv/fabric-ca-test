 kill $(lsof -i:7052 |awk '{print $2}')
sudo rm -r /home/dinglab-dell/go-workspace/fabric-ca-test/hyperledger/org0/orderer/tls-msp
sudo rm -r /home/dinglab-dell/go-workspace/fabric-ca-test/hyperledger/org1/peer1/tls-msp
sudo rm -r /home/dinglab-dell/go-workspace/fabric-ca-test/hyperledger/org1/peer2/tls-msp
sudo rm -r /home/dinglab-dell/go-workspace/fabric-ca-test/hyperledger/org2/peer1/tls-msp
sudo rm -r /home/dinglab-dell/go-workspace/fabric-ca-test/hyperledger/org2/peer2/tls-msp
sudo rm -r /home/dinglab-dell/go-workspace/fabric-ca-test/hyperledger/tls/ca/crypto/msp
cd /home/dinglab-dell/go-workspace/fabric-ca-test/hyperledger/tls/ca/crypto
sudo rm ca-cert.pem fabric-ca-server.db IssuerPublicKey IssuerRevocationPublicKey tls-cert.pem