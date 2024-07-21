FROM docker.io/zmkfirmware/zmk-dev-arm:3.5

RUN mkdir -p /workspaces

COPY . /workspaces/zmk-config

WORKDIR /root

RUN git clone -b $(cat /workspaces/zmk-config/config/west.yml | grep -A3 "remote: zmkfirmware" | grep revision | cut -d':' -f2-) $(cat /workspaces/zmk-config/config/west.yml | grep -A2 "name: zmkfirmware" | grep url | cut -d':' -f2-)/zmk

# RUN west init --mf /workspaces/zmk-config/config/west.yml && west update zmk; rm -rf .west
RUN cd zmk && west init -l app/ --mf /workspaces/zmk-config/config/west.yml && west update -n

WORKDIR /root/zmk/app

CMD ["/bin/bash"]
