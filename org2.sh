# org2-ca server

export FABRIC_CA_SERVER_HOME=$HOME/fabric-ca-test/hyperledger/org2/ca/crypto
export FABRIC_CA_SERVER_PORT=7055
export FABRIC_CA_SERVER_CA_NAME=org2-ca
export FABRIC_CA_SERVER_CSR_CN=org2-ca
export FABRIC_CA_SERVER_DEBUG=true
export FABRIC_CA_SERVER_TLS_ENABLED=false
export FABRIC_CA_SERVER_CSR_HOSTS=0.0.0.0
export FABRIC_CA_SERVER_BCCSP_SW_HASH=SHA2
export FABRIC_CA_SERVER_BCCSP_SW_SECURITY=384

fabric-ca-server start -b org2-ca-admin:org2-ca-adminpw --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384


# org2-ca admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org2/ca/admin
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://org2-ca-admin:org2-ca-adminpw@0.0.0.0:7055 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384
fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1-org2pw --id.type peer -u http://0.0.0.0:7055
fabric-ca-client register -d --id.name peer2-org2 --id.secret peer2-org2pw --id.type peer -u http://0.0.0.0:7055
fabric-ca-client register -d --id.name admin-org2 --id.secret admin-org2pw --id.type user -u http://0.0.0.0:7055
fabric-ca-client register -d --id.name user-org2 --id.secret user-org2pw --id.type user -u http://0.0.0.0:7055

# org2 peer1 在 org2 ca enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org2/peer1
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_MSPDIR=msp
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://peer1-org2:peer1-org2pw@0.0.0.0:7055 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# org2 peer1 在 tls CA enroll
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
fabric-ca-client enroll -d -u https://peer1-org2:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-org2 --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384

# org2 peer2
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org2/peer2
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_MSPDIR=msp
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://peer2-org2:peer2-org2pw@0.0.0.0:7055 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# org2 peer2 在 tls CA enroll
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
fabric-ca-client enroll -d -u https://peer2-org2:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer2-org2 --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384

# org2 admin
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org2/admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_MSPDIR=msp
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://admin-org2:admin-org2pw@0.0.0.0:7055 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# 把管理员证书放到peer的amdincert证书中
sudo mkdir $HOME/fabric-ca-test/hyperledger/org2/peer1/msp/admincerts
sudo mkdir $HOME/fabric-ca-test/hyperledger/org2/peer2/msp/admincerts
sudo cp $HOME/fabric-ca-test/hyperledger/org2/admin/msp/signcerts/cert.pem $HOME/fabric-ca-test/hyperledger/org2/peer1/msp/admincerts
sudo cp $HOME/fabric-ca-test/hyperledger/org2/admin/msp/signcerts/cert.pem $HOME/fabric-ca-test/hyperledger/org2/peer2/msp/admincerts