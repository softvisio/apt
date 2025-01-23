```shell
export GNUPGHOME="$(mktemp -d)"

cat > foo << EOF
     Key-Type: ECDSA
     Key-Curve: NIST P-384
     Key-Usage: sign
     Name-Email: apt@softvisio.net
     Expire-Date: 0
     %pubring pubring.kbx
     %no-protection
     %commit
EOF

gpg --batch --generate-key foo

gpg --list-secret-keys --no-default-keyring --keyring ./pubring.kbx

gpg --keyring ./pubring.kbx --armor --export-secret-keys --output private-key.pem apt@softvisio.net
gpg --keyring ./pubring.kbx --armor --export --output public-key.pem apt@softvisio.net

gpg --dearmor -o pubring.kbx private-key.pem

gpg --clearsign --keyring ./pubring.kbx --output foo.sign foo

gpg --verify --keyring ./pubring.kbx foo.sign
```
