# tls-ca server
export FABRIC_CA_SERVER_HOME=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto
export FABRIC_CA_SERVER_CA_NAME=ca-tls
export FABRIC_CA_SERVER_CSR_CN=ca-tls
export FABRIC_CA_SERVER_PORT=7052
export FABRIC_CA_SERVER_DEBUG=true
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_CSR_HOSTS=0.0.0.0
export FABRIC_CA_SERVER_BCCSP_SW_HASH=SHA2
export FABRIC_CA_SERVER_BCCSP_SW_SECURITY=384

fabric-ca-server start -b tls-ca-admin:tls-ca-adminpw --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384


# tls-ca admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/ca-cert.pem
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