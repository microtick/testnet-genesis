# Microtick Testnet

## Requirements

You must have the mtm 2.0.5 binary in your path, available from here:

```
Source: https://github.com/microtick/mtzone (main branch, tag mtm-v2.0.5)
Binary: https://microtick.com/releases/mainnet
```

To build from source, ensure you have the unzip utility installed on your system.

## Syncing a node

### Full sync script (method 1)
```
$ ./fullsync.sh
```

### Manual config/syncing (method 2) 
Don't run in the same profile than your MainNet validator
```
wget https://microtick.com/releases/mainnet/microtick-v2.0.5-linux-x86_64.tar.gz
tar zxvf microtick-v2.0.5-linux-x86_64.tar.gz 
chmod +x mtm
sudo mv mtm /usr/local/bin
mtm init yourpeer --chain-id microtick-test-1
curl -s https://raw.githubusercontent.com/microtick/testnet-genesis/main/genesis.json > ~/.microtick/config/genesis.json
sed -E -i 's/seeds = \".*\"/seeds = \"8ada4746da93d37726c5e4c3880d3495ec4aeeb4@164.68.119.233:26656\"/' $HOME/.microtick-testnet/config/config.toml
sed -E -i 's/minimum-gas-prices = \".*\"/minimum-gas-prices = \"0.001stake\"/' $HOME/.microtick-testnet/config/app.toml
```
And now start the daemon:
```
mtm start
```
### Become validator
After get some test-coins (ask in Discord): 
```
mtm tx staking create-validator \
    --amount 99000000stake \
    --commission-max-change-rate 0.10 \
    --commission-max-rate 0.2 \
    --commission-rate 0.1 \
    --from WALLET_NAME \
    --min-self-delegation 1 \
    --moniker YOUR_MONIKER \
    --pubkey $(mtm tendermint show-validator) \
    --chain-id microtick-testnet-1 \
    --fees 3000stake
```
  
