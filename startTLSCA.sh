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