#!/bin/bash

# install
# /bin/bash <(curl -fsSL https://raw.githubusercontent.com/softvisio/apt/main/setup.sh) install

# re-install
# /bin/bash <(curl -fsSL https://raw.githubusercontent.com/softvisio/apt/main/setup.sh) reinstall

# remove
# /bin/bash <(curl -fsSL https://raw.githubusercontent.com/softvisio/apt/main/setup.sh) remove

set -e

REPO_NAME=softvisio
REPO_SLUG=softvisio/apt
COMPONENT=main
VERSION_ID=$(. /etc/os-release && echo $VERSION_ID)

function _remove() {
    rm -rf /usr/share/keyrings/${REPO_NAME}-archive-keyring.gpg
    rm -rf /etc/apt/sources.list.d/${REPO_NAME}.list

    apt-get clean all

}

function _install() {
    _remove

    apt-get install -y gpg

    curl -fsSL https://raw.githubusercontent.com/$REPO_SLUG/main/public-key.gpg | gpg --dearmor -o /usr/share/keyrings/${REPO_NAME}-archive-keyring.gpg

    # deb [trusted=yes] https://raw.githubusercontent.com/$repo_slug/ $version_id $component

    cat << EOF > /etc/apt/sources.list.d/${REPO_NAME}.list
deb [signed-by=/usr/share/keyrings/${REPO_NAME}-archive-keyring.gpg] https://raw.githubusercontent.com/$REPO_SLUG/ $VERSION_ID $COMPONENT
EOF

}

case "$1" in
    install)
        _install
        ;;

    reinstall)
        _remove
        _install
        ;;

    remove)
        _remove
        ;;

    *)
        return 1
        ;;
esac
