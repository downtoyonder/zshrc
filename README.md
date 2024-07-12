# zshrc applyer

This repo manage self-used zshrc configs, can be applied on MacOS and Linux. Including:
- Alias
- Key Binding
- Application Setting
- Zsh plugin (helped by zplug)

## Quick Start

```bash
make apply-config
```

## Test Modify Correctness

```bash
# build test image
make build-test
# run test in container
make run-test
```

## Config Call Order

![config-call-order](./repos/img/zshrc_apply_design.excalidraw.svg)

