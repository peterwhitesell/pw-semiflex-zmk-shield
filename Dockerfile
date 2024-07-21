FROM mikefarah/yq AS yq

FROM docker.io/zmkfirmware/zmk-dev-arm:3.5

RUN mkdir -p /workspaces

COPY . /workspaces/zmk-config

WORKDIR /root

COPY --from=yq /usr/bin/yq /usr/bin/yq

RUN git clone -b $(yq e '.manifest.projects[] | select(.remote == "zmkfirmware").revision' /workspaces/zmk-config/config/west.yml) $(yq e '.manifest.remotes[] | select(.name == "zmkfirmware").url-base' /workspaces/zmk-config/config/west.yml)/zmk

RUN cd zmk && west init -l app/ --mf /workspaces/zmk-config/config/west.yml && west update -n

WORKDIR /root/zmk/app

COPY ./scripts/_build /usr/local/bin/build

ENTRYPOINT ["build"]
