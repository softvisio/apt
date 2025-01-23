```shell
export GNUPGHOME="$(mktemp -d)"

gpg --batch --generate-key << EOF
     Key-Type: ECDSA
     Key-Curve: NIST P-384
     Key-Usage: sign
     Name-Email: apt@softvisio.net
     Expire-Date: 0
     %no-protection
     %commit
EOF

gpg --export --armor --output public-key.asc apt@softvisio.net
gpg --export-secret-key --armor --output private-key.asc apt@softvisio.net

gpg --import private-key.asc

gpg --clearsign private-key.asc
gpg --verify private-key.asc.asc
```
