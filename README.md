# Apt repository

### Install repository

```shell
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/softvisio/apt/main/setup.sh) install
```

### Remove repository

```shell
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/softvisio/apt/main/setup.sh) remove
```

### Manually install GPG key

Import public key

```shell
curl -fsSL https://raw.githubusercontent.com/softvisio/apt/main/public-key.asc | gpg --dearmor -o /usr/share/keyrings/softvisio-archive-keyring.gpg
```

### GPG

Generate key:

```shell
export GNUPGHOME="$(mktemp -d)"

gpg --batch --generate-key << EOF
    Name-Email: apt@softvisio.net
    Name-Real:
    Name-Comment:
    Key-Type: ECDSA
    Key-Curve: NIST P-384
    Key-Usage: sign
    Expire-Date: 0
    Keyserver: hkps://keyserver.ubuntu.com
    %no-protection
    %commit
EOF

gpg --export --armor --output public-key.asc apt@softvisio.net
gpg --export-secret-key --armor --output private-key.asc apt@softvisio.net
```

Sign:

```shell
gpg --import private-key.asc

gpg --clearsign private-key.asc
```

### Init reposutory

```shell
# clone "main" branch
git clone --single-branch --branch main git@github.com:softvisio/apt.git

# clone "dists" branch
git clone --single-branch --branch dists git@github.com:softvisio/apt.git dists

# init "dists" branch
git switch --orphan dists
git commit --allow-empty -m "chore: init"
git push -u origin dists
```

### Work with packages

You need `@softvisio/cli` package:

```shell
npm install --global @softvisio/cli
```

Build docker images:

```shell
softvisio-cli apt build-images
```

Build packages:

```shell
# build all packages
softvisio-cli apt build all

# build "nginx-stable" package
softvisio-cli apt build nginx-stable
```

Update repository data:

```shell
softvisio-cli update
```
