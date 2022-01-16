#!/bin/sh
set -e

TESTNET_DIR=$HOME/.microtick-testnet
BACKUP_DIR=$HOME/.microtick-testnet.backup
DATE_BACKUP=`date +"%d_%m_%Y-%H_%M_%S"`

# Test if mtm is in path
mtm --help > /dev/null 2>&1
MTM_RESULT=$?
if [ $MTM_RESULT -ne 0 ]; then
    echo "mtm: executable not found, please download the latest from here: https://microtick.com/releases/mainnet/"
    exit 1
fi

if [ -d $TESTNET_DIR ]; then
    echo "$TESTNET_DIR exists: backing it up first"
    mkdir -p $BACKUP_DIR
    tar cvfz $BACKUP_DIR/microtick_folder_backup_$DATE_BACKUP.tgz -C $TESTNET_DIR --exclude="./data/cs.wal" --exclude="./data/application.db" --exclude="./data/blockstore.db" --exclude="./data/evidence.db" --exclude="./data/snapshots" --exclude="./data/state.db" --exclude="./data/tx_index.db" .
    mtm unsafe-reset-all
else
    if [[ "$#" -ne 1 ]]; then
        BASE=$(basename $0)
        echo "When starting a node for the first time, you should choose a moniker"
        echo "usage: $BASE: <moniker>"
        exit 1
    fi
    MONIKER=$1
    mtm init $MONIKER --home $TESTNET_DIR > /dev/null 2>&1
fi

cp ./genesis.json $TESTNET_DIR/config
sed -i.bak -E "s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"ed659a70fa610cd8034733c5f9174bb95f54eedb@45.79.187.79:26656\"|" $HOME/.microtick-testnet/config/config.toml

echo 
echo "Setup complete"
echo "Next, run 'MTM_HOME=$TESTNET_DIR mtm start' from the command line, or configure a systemd service to do it."

