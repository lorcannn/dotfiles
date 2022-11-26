# dotfiles

利用 Homebrew 和 Mackup 优雅的备份和恢复电脑开发环境

# 遇到的问题

1. 每次更换电脑都要重新安装开发环境配置和各类常用软件
2. 最令人头疼的是一些软件的插件及个性化配置的迁移

例如我要做:

- 安装 Homebrew
- 再用 Homebrew 安装常用软件. vscode，iTerm，nvm，Chrome...
- 增加配置文件，配置环境变量，如 nvm
- 安装 vscode 的常用插件
- 配置插件
- 安装 iTerm 插件
- 配置插件
- ...

整个流程繁琐耗时，怎么解?

# 解法

## 解决软件安装效率问题

使用 [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) 优雅的备份和恢复软件列表

### 批量备份 homebrew 软件

```
# 执行brew bundle dump备份命令
brew bundle dump --describe --force --file="~/dotfiles/homebrew/Brewfile"

# 参数说明
--describe：为列表中的命令行工具加上说明性文字。
--force：直接覆盖之前生成的Brewfile文件。如果没有该参数，则询问你是否覆盖。
--file="~/dotfiles/Brewfile"：在指定位置生成文件。如果没有该参数，则在当前目录生成 Brewfile 文件。
```

### 批量安装 homebrew 软件

```
brew bundle --file="~/your/path/to/Brewfile"
```

### 手动备份 vscode 插件

```
# 手动复制插件 ID 后在 vscode/setup.sh 中添加执行命令，如下命令将安装 eslint 插件
code --install-extension dbaeumer.vscode-eslint
```

### 批量安装 vscode 插件

```
# vscode 安装成功后执行该文件，利用 vscode 提供的 code 命令批量安装插件
/vscode/setup.sh
```

## 解决配置迁移问题

一切配置皆文件，所以只要解决文件同步该问题迎刃而解，这里可以使用 git 或云同步工具。
这里还有一个小问题就是，从 git 同步下来配置文件如何生效?
不同软件的配置文件放在固定目录，一定是分散在文件系统的各个角落，而我们 git 同步下来的文件是按照我们自己定义的结构保存的，这里就需要处理一下，让我们的拉下来的配置文件生效。

解法就是使用「软连接」

ln 命令是 linux 下一个十分重要也有用的命令，它可以为一个文件在另外一个地方建立一个同步的链接，类似于快捷键。
ln [参数] [源文件或目录] [目标文件或目录]
ln -s 创建软链接命令，s 是代号 symbolic 的意思，所谓软链接，它只会在你选定的位置上生成一个镜像，而不会占用磁盘空间，而如果使用 ln 不带参数的话，则就是硬链接，会在选定的位置上生成一个和源文件大小相同的文件，占用磁盘空间。

### 备份过程

将默认的配置文件全部移动到备份目录，然后通过软连接重定位配置文件的位置：

cp ~/.zshrc ~/dotfiles/.zshrc
rm ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc

### 还原过程

将 dotfiles 里的备份配置软链到实际位置：

ln -s ~/dotfiles/.zshrc ~/.zshrc

上述过程可以手写脚本也可以使用 [Mackup](https://github.com/lra/mackup) 这个工具完成

# 如何使用

## 备份配置

1. 初始化目录

```bash
# 找一个你喜欢的地方放置 dotfiles 文件夹,例如你的用户根目录
cd ~

# 你可以 clone 我的这个模板
git clone https://github.com/lorcannn/dotfiles.git

# 或者你也可以自己控制目录结构
mkdir dotfiles
...
```

2. 备份 Homebrew 软件

```bash
# 执行brew bundle dump备份命令
brew bundle dump --describe --force --file="~/dotfiles/homebrew/Brewfile"
```

3. 确认 vscode 插件

```bash

# 手动复制插件 ID 后在 vscode/setup.sh 中添加执行命令，如下命令将安装 eslint 插件
code --install-extension dbaeumer.vscode-eslint

```

4. 备份其他配置文件

```bash
# 通过 Homebrew (http://brew.sh/) 安装

brew install mackup

# 创建 Mackup 的配置文件 参考: https://github.com/lra/mackup/blob/master/doc/README.md

touch ~/.mackup.cfg

# 备份

mackup backup

```

5. 上传代码到你的仓库

## 初始化新设备

请确保电脑上安装了如下软件:

- Git

```bash

git -v

```

- Homebrew

```bash

brew -v

```

- Mackup

```bash

mackup --version

```

1. 拉取你的 dotfiles 仓库

```bash
git clone https://github.com/{yourname}/dotfiles.git

# 增加权限
chmod u+x ~/dotfiles/**/*.sh
```

2. 使用 Homebrew 安装软件

```bash
/dotfiles/homebrew/setup.sh
```

3. 安装 vscode 插件

```bash
/dotfiles/vscode/setup.sh
```

4. 恢复其他配置文件

```bash
# 生成 mackup 配置文件
~/dotfiles/bootstrap.sh

# 还原备份的文件
mackup restore
```

# 参考:

- https://github.com/cpojer/dotfiles
- https://dotfiles.github.io/
