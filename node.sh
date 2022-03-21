# orderer configx的msp需求
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org0/msp/admincerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org0/msp/cacerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org0/msp/tlscacerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org0/msp/users
sudo cp $HOME/fabric-ca-test/hyperledger/org0/admin/msp/signcerts/cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org0/msp/admincerts
sudo cp $HOME/fabric-ca-test/hyperledger/org0/ca/crypto/ca-cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org0/msp/cacerts
sudo cp $HOME/fabric-ca-test/hyperledger/tls/ca/crypto/ca-cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org0/msp/tlscacerts


sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org1/msp/admincerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org1/msp/cacerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org1/msp/tlscacerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org1/msp/users
sudo cp $HOME/fabric-ca-test/hyperledger/org1/admin/msp/signcerts/cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org1/msp/admincerts
sudo cp $HOME/fabric-ca-test/hyperledger/org1/ca/crypto/ca-cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org1/msp/cacerts
sudo cp $HOME/fabric-ca-test/hyperledger/tls/ca/crypto/ca-cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org1/msp/tlscacerts

sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org2/msp/admincerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org2/msp/cacerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org2/msp/tlscacerts
sudo mkdir -p $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org2/msp/users
sudo cp $HOME/fabric-ca-test/hyperledger/org2/admin/msp/signcerts/cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org2/msp/admincerts
sudo cp $HOME/fabric-ca-test/hyperledger/org2/ca/crypto/ca-cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org2/msp/cacerts
sudo cp $HOME/fabric-ca-test/hyperledger/tls/ca/crypto/ca-cert.pem $HOME/fabric-ca-test/nodeconfig/org0_order/organizations/org2/msp/tlscacerts

# 生成创世区块
export FABRIC_CFG_PATH=$HOME/fabric-ca-test/nodeconfig/org0_order
configtxgen -profile TwoOrgsOrdererGenesis -outputBlock /home/dinglab-dell/fabric-ca-test/node/orderer-org0/genesis.block -channelID syschannel
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx /home/dinglab-dell/fabric-ca-test/nodeconfig/org0_order/channel.tx -channelID mychannel

orderer

export FABRIC_CFG_PATH=$HOME/fabric-ca-test/nodeconfig/org1_peer1
peer node start

export FABRIC_CFG_PATH=$HOME/fabric-ca-test/nodeconfig/org1_peer2
peer node start

export FABRIC_CFG_PATH=$HOME/fabric-ca-test/nodeconfig/org2_peer1
peer node start

export FABRIC_CFG_PATH=$HOME/fabric-ca-test/nodeconfig/org2_peer2
peer node start
