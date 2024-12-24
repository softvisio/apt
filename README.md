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

Importl public key

```shell
curl -fsSL https://raw.githubusercontent.com/softvisio/apt/main/public-key.gpg | gpg --dearmor -o /usr/share/keyrings/softvisio-archive-keyring.gpg
```

### Export / import private key

Export:

```shell
gpg --export-secret-keys apt@softvisio.net > private.key
```

Export public key:

```shell
gpg --armor --export apt@softvisio.net --output public-key.gpg
```

Import:

```shell
gpg --import private.key
```

### Sign

```shell
gpg --clearsign --yes -u apt@softvisio.net -o InRelease Release
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
