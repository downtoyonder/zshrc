FROM ubuntu:22.04 

ARG IN_DOCKER=true

WORKDIR /root/.config/zshrc

COPY . .

RUN apt update && apt install -y make && \
	make clean

ENTRYPOINT ["make", "apply-config"]