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

# org0-ca admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org0/ca/admin
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://org0-ca-admin:org0-ca-adminpw@0.0.0.0:7053 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384
fabric-ca-client register -d --id.name orderer-org0 --id.secret orderer-org0pw --id.type orderer -u http://0.0.0.0:7053
fabric-ca-client register -d --id.name admin-org0 --id.secret admin-org0pw --id.type admin --id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" -u http://0.0.0.0:7053

# org0 orderer 在 org0 CA enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org0/orderer
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_MSPDIR=msp
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://orderer-org0:orderer-org0pw@0.0.0.0:7053 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# org0 orderer 在 tls CA enroll
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
fabric-ca-client enroll -d -u https://orderer1-org0:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-org0 --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384


# org0 admin
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org0/admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_MSPDIR=msp
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://admin-org0:admin-org0pw@0.0.0.0:7053 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# 把管理员证书放到peer的amdincert证书中
sudo mkdir $HOME/fabric-ca-test/hyperledger/org0/orderer/msp/admincerts
sudo cp $HOME/fabric-ca-test/hyperledger/org0/admin/msp/signcerts/cert.pem $HOME/fabric-ca-test/hyperledger/org0/orderer/msp/admincerts