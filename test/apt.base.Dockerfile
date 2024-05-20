FROM ubuntu:22.04 

WORKDIR /root/.config/zshrc

RUN apt update && \
	apt install -y git