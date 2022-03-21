# order-ca server
export FABRIC_CA_SERVER_DEBUG=true
export FABRIC_CA_SERVER_HOME=$HOME/fabric-ca-test/test/order-ca/crypto
export FABRIC_CA_SERVER_CA_NAME=order-ca
export FABRIC_CA_SERVER_TLS_ENABLED=false
export FABRIC_CA_SERVER_CSR_CN=order-ca
export FABRIC_CA_SERVER_CSR_HOSTS=0.0.0.0
export FABRIC_CA_SERVER_PORT=7053
export FABRIC_CA_SERVER_BCCSP_SW_HASH=SHA2
export FABRIC_CA_SERVER_BCCSP_SW_SECURITY=384

fabric-ca-server start -b order-ca-admin:order-ca-adminpw --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# order-ca admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/test/order-ca-admin/crypto
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://order-ca-admin:order-ca-adminpw@0.0.0.0:7053 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384
fabric-ca-client register -d --id.name orderer --id.secret ordererpw --id.type orderer -u http://0.0.0.0:7053
fabric-ca-client register -d --id.name orderer-admin --id.secret orderer-adminpw --id.type admin --id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" -u http://0.0.0.0:7053

# org1-ca server
export FABRIC_CA_SERVER_DEBUG=true
export FABRIC_CA_SERVER_HOME=$HOME/fabric-ca-test/test/org1-ca/crypto
export FABRIC_CA_SERVER_CA_NAME=org1-ca
export FABRIC_CA_SERVER_TLS_ENABLED=false
export FABRIC_CA_SERVER_CSR_CN=org1-ca
export FABRIC_CA_SERVER_CSR_HOSTS=0.0.0.0
export FABRIC_CA_SERVER_PORT=7054
export FABRIC_CA_SERVER_BCCSP_SW_HASH=SHA2
export FABRIC_CA_SERVER_BCCSP_SW_SECURITY=384

fabric-ca-server start -b org1-ca-admin:org1-ca-adminpw --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384


# org1-ca admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/test/org1-ca-admin/crypto
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://org1-ca-admin:org1-ca-adminpw@0.0.0.0:7054 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384


sudo rm -r test

