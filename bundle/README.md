# Bundle of rpchub and node


## Before start

```shell
# create wallet and block dir
mkdir -p /data/blockchain/iota/{node,rpchub}
```

## Managing

```shell
# start
docker-compose up -d

# stop
docker-compose down

# monitor
docker-compose ps
docker-compose logs -f
```
