# org1-ca server
export FABRIC_CA_SERVER_HOME=$HOME/fabric-ca-test/hyperledger/org1/ca/crypto
export FABRIC_CA_SERVER_CA_NAME=org1-ca
export FABRIC_CA_SERVER_CSR_CN=org1-ca
export FABRIC_CA_SERVER_PORT=7054
export FABRIC_CA_SERVER_DEBUG=true
export FABRIC_CA_SERVER_TLS_ENABLED=false
export FABRIC_CA_SERVER_CSR_HOSTS=0.0.0.0
export FABRIC_CA_SERVER_BCCSP_SW_HASH=SHA2
export FABRIC_CA_SERVER_BCCSP_SW_SECURITY=384

fabric-ca-server start -b org1-ca-admin:org1-ca-adminpw --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384


# org1-ca admin
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org1/ca/admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://org1-ca-admin:org1-ca-adminpw@0.0.0.0:7054 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384
fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1-org1pw --id.type peer -u http://0.0.0.0:7054
fabric-ca-client register -d --id.name peer2-org1 --id.secret peer2-org1pw --id.type peer -u http://0.0.0.0:7054
fabric-ca-client register -d --id.name admin-org1 --id.secret admin-org1pw --id.type user -u http://0.0.0.0:7054
fabric-ca-client register -d --id.name user-org1 --id.secret user-org1pw --id.type user -u http://0.0.0.0:7054

# org1 peer1 在 org1 CA enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org1/peer1
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_MSPDIR=msp
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://peer1-org1:peer1-org1pw@0.0.0.0:7054 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# org1 peer1 在 tls CA enroll
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
fabric-ca-client enroll -d -u https://peer1-org1:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts localhost --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384


# org1 peer2 在 org1 CA enroll
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org1/peer2
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_MSPDIR=msp
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://peer2-org1:peer2-org1pw@0.0.0.0:7054 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# org1 peer2 在 tls CA enroll
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=$HOME/fabric-ca-test/hyperledger/tls/ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
fabric-ca-client enroll -d -u https://peer2-org1:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts localhost  --csr.keyrequest.algo ecdsa --csr.keyrequest.size 384

# org1 admin
export FABRIC_CA_CLIENT_HOME=$HOME/fabric-ca-test/hyperledger/org1/admin
export FABRIC_CA_CLIENT_DEBUG=true
export FABRIC_CA_CLIENT_MSPDIR=msp
export FABRIC_CA_CLIENT_BCCSP_SW_HASH=SHA2
export FABRIC_CA_CLIENT_BCCSP_SW_SECURITY=384
fabric-ca-client enroll -d -u http://admin-org1:admin-org1pw@0.0.0.0:7054 --csr.keyrequest.algo Dilithium3 --csr.keyrequest.size 384

# 把管理员证书放到peer的amdincert证书中
sudo mkdir $HOME/fabric-ca-test/hyperledger/org1/peer1/msp/admincerts
sudo mkdir $HOME/fabric-ca-test/hyperledger/org1/peer2/msp/admincerts
sudo cp $HOME/fabric-ca-test/hyperledger/org1/admin/msp/signcerts/cert.pem $HOME/fabric-ca-test/hyperledger/org1/peer1/msp/admincerts
sudo cp $HOME/fabric-ca-test/hyperledger/org1/admin/msp/signcerts/cert.pem $HOME/fabric-ca-test/hyperledger/org1/peer2/msp/admincerts