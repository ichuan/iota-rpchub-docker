# iota-rpchub-docker
rpchub docker builds


## Running

```
docker run --rm -it --name iota-rpchub-node -p 0.0.0.0:50051:50051 -v iota-rpchub:/data iota-rpchub:latest
```

## Persist data

By using [CWSpear/local-persist](https://github.com/CWSpear/local-persist):

```
curl -fsSL https://raw.githubusercontent.com/CWSpear/local-persist/master/scripts/install.sh | sudo bash
docker volume create -d local-persist -o mountpoint=/data/iota-rpchub --name=iota-rpchub
```

## Using pre-built docker image

Using automated build image from <https://hub.docker.com/r/mixhq/iota-rpchub/>:

```
docker run --rm -it --name iota-rpchub-node -p 0.0.0.0:50051:50051 -v iota-rpchub:/data mixhq/iota-rpchub:latest
```

