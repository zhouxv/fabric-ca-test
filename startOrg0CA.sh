# org0-ca server
export FABRIC_CA_SERVER_HOME=$HOME/fabric-ca-test/hyperledger/org0/ca/crypto
export FABRIC_CA_SERVER_CSR_CN=org0-ca
export FABRIC_CA_SERVER_CA_NAME=org0-ca
export FABRIC_CA_SERVER_PORT=7053
export FABRIC_CA_SERVER_DEBUG=true
export FABRIC_CA_SERVER_TLS_ENABLED=false
export FABRIC_CA_SERVER_CSR_HOSTS=0.0.0.0
export FABRIC_CA_SERVER_BCCSP_SW_HASH=SHA2
export FABRIC_CA_SERVER_BCCSP_SW_SECURITY=384

fabric-ca-server start -b org0-ca-admin:org0-ca-adminpw --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384