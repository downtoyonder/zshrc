# ubuntu 测试镜像
# 假设当前镜像构建时的名称为 zshrc_test:1.0，
# 则测试时执行 d run --rm -it zshrc_test:1.0
FROM ubuntu:22.04

WORKDIR /root/.config/zshrc
COPY . /root/.config/zshrc

ENTRYPOINT bash apply.sh