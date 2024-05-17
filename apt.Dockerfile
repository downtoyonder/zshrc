# ubuntu 测试镜像
# 假设当前镜像构建时的名称为 zshrc:1.0，
# 则测试时执行 docker run --rm -it zshrc:1.0
FROM ubuntu:22.04 AS builder

WORKDIR /root/.config/zshrc

RUN apt update && \
	apt install -y git

# ------


FROM builder AS runner

RUN git clone https://github.com/downtoyonder/zshrc.git --depth=1 /root/.config/zshrc

ENTRYPOINT bash apply.sh