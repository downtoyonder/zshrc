FROM ubuntu:22.04 

ARG IN_DOCKER=true

WORKDIR /root/.config/zshrc

RUN apt update && apt install -y make git && \
	git clone https://github.com/downtoyonder/zshrc.git . && \
	make clean

ENTRYPOINT ["make", "apply-config"]