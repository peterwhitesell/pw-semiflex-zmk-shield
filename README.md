# pw-semiflex-zmk-shield
ZMK config for `pw-semiflex` shield.

## Build
### GitHub Action
The default zmk user-config GitHub actions will build firmware for both right and left sides. 

### Local in Docker
Build this configuration of zmk firmware locally in docker with `docker-compose run --rm -it zmk [right|left]`. If you don't pass `left` or `right`, both will be built. The resulting firmware is saved at `./<side>.uf2`, which are gitignored.

During the first build on your local system, the docker build takes several minutes, mostly due to `west update` installing the zephyr project dependencies. Subsequent builds should be must faster, for me `~25s`/side.

The only dependencies you need installed on your system are `docker` ([Install Docker Engine](https://docs.docker.com/engine/install/)) and `docker-compose` ([Install Docker Compose](https://docs.docker.com/compose/install/)) and `bash`.

> [!NOTE]
> You can easily copy this docker build setup to your own zmk user config repo, as long as you have `build.yaml` at the project root and west config at `config/west.yaml`. You will need these files: `.dockerignore`, `Dockerfile`, `docker-compose.yaml`, `scripts/`
