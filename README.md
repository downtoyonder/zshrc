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

## Validate Modification Correctness

```bash
# build test image
make build-test

# run test in container
make run-test
```

## Config Call Order

![config-call-order](./repos/img/zshrc_apply_design.excalidraw.svg)


## Folder and File Architecture

- `apply/apply.sh`: the entry point for the configuration scripts, including
  - Setting up global shared tools to install, such as `git` and `make`.
  - Selecting and loading platform-specific configuration files, which include platform installers (e.g., `apt` for Debian-based systems and `brew` for macOS).
- `config/*.zsh`: More specific Zsh configurations, including:
  - `zshrc.zsh`: Manages which .zsh files to load and their load order.
  - `environment.zsh`: System-level environment configuration.
  - `option.zsh`: Zsh option settings.
  - `alias.zsh`: Global alias.
  - `darwin.zsh`: macOS-specific configuration.
  - `linux.zsh`: Linux-specified configuration.
  - `application.zsh`: Application-specific configurations, including the app's own settings, shortcuts, aliases, environment variables, and user-defined helper functions.
  - `function.zsh`: User-defined helper functions that are independent of applications or combine functionalities of multiple applications.