#!/bin/sh
# Setup a machine for VSCode
set -x

# 安装插件,待补充
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
# 主题插件
code --install-extension sdras.night-owl
code --install-extension naumovs.color-highlight
code --install-extension wayou.vscode-todo-highlight
code --install-extension vscode-convert-utils.vscode-js-console-utils
code --install-extension techer.open-in-browser
code --install-extension jasonnutter.search-node-modules
code --install-extension ritwickdey.LiveServer
code --install-extension mhutchie.git-graph
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension zhang-renyang.rm-js-comment
code --install-extension formulahendry.code-runner