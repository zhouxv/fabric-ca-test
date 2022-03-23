sh ./startTLSCA.sh &
sleep 2
# tls-ca admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/tls/ca/admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u https://tls-ca-admin:tls-ca-adminpw@0.0.0.0:7052 --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384
fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer2-org1 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name peer2-org2 --id.secret peer2PW --id.type peer -u https://0.0.0.0:7052
fabric-ca-client register -d --id.name orderer1-org0 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052

# org0 orderer 在 tls CA enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org0/orderer
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
fabric-ca-client enroll -d -u https://orderer1-org0:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts localhost --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384


# org1 peer1 在 tls CA enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org1/peer1
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_DEBUG=true
fabric-ca-client enroll -d -u https://peer1-org1:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts localhost --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384

# org1 peer2 在 tls CA enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org1/peer2
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_DEBUG=true
fabric-ca-client enroll -d -u https://peer2-org1:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts localhost  --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384


# org2 peer1 在 tls CA enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org2/peer1
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
fabric-ca-client enroll -d -u https://peer1-org2:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts localhost --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384

# org2 peer2 在 tls CA enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org2/peer2
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
fabric-ca-client enroll -d -u https://peer2-org2:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts localhost --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384
