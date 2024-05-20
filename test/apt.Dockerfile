FROM zshrc:apt.base

RUN git clone https://github.com/downtoyonder/zshrc.git --depth=1 /root/.config/zshrc

ENTRYPOINT bash apply.sh