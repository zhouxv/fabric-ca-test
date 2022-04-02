# org2-ca server
export FABRIC_CA_SERVER_HOME=$HOME/go-workspace/fabric-ca-test/hyperledger/org2/ca/crypto
export FABRIC_CA_SERVER_PORT=7055
export FABRIC_CA_SERVER_CA_NAME=org2-ca
export FABRIC_CA_SERVER_CSR_CN=org2-ca
export FABRIC_CA_SERVER_DEBUG=true
export FABRIC_CA_SERVER_TLS_ENABLED=false
export FABRIC_CA_SERVER_CSR_HOSTS=0.0.0.0
export FABRIC_CA_SERVER_BCCSP_SW_HASH=SHA2
export FABRIC_CA_SERVER_BCCSP_SW_SECURITY=384

fabric-ca-server start -b org2-ca-admin:org2-ca-adminpw --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384