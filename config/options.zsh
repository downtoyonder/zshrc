# shell options as history size, keyindings, etc

# ***************************************************************************
# * Key Bind
# ***************************************************************************

# ***************************************************************************
# * History Setting
# ***************************************************************************

# History Settings (big history for use with many open shells and no dups)
# Different History files for root and standard user
if ((!EUID)); then
	HISTFILE=$ZSH_CACHE/history_root
else
	HISTFILE=$ZSH_CACHE/history
fi
SAVEHIST=10000
HISTSIZE=12000
setopt share_history append_history extended_history hist_no_store hist_ignore_all_dups hist_ignore_space

# If a command is issued that can’t be executed as a normal command,
# and the command is the name of a directory, perform the cd command to that directory.
# 输入文件夹名自动 cd
setopt AUTO_CD

# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.
# (An initial unquoted ‘~’ always produces named directory expansion.)
# 将 ‘#’, ‘~’ and ‘^’ 看作是正则表达式的 pattern，而不是一般符号，因为 ‘#’, ‘~’ and ‘^’ 作为文件名也是合法的。
# 设置效果如下：
# $ touch 'foo' 'bar' '^foo' '^bar'
#- $ ls ^foo*
#- > ^foo
#- $ setopt extendedglob
#- $ ls ^foo*
#- > bar  ^bar  ^foo
# 当没有设置 extendedglob 时，ls ^foo* 的意思是列出当前目录下以 ^foo 开头的所有文件
# 当设置了 extendedglob 时，ls ^foo* 的意思是列出当前目录下除了以 foo 开头的其他所有文件
setopt EXTENDED_GLOB

# NOMATCH
# If a pattern for filename generation has no matches, print an error, instead of leaving it unchanged in the argument list.
# This also applies to file expansion of an initial ‘~’ or ‘=’.
# 如果没有匹配的 pattern，提示 no match found
# 与之相对的，是 setopt NONOMATCH
#- $ ls A?
#- > ls: A?: No such file or directory
#- $ set nomatch
#- $ ls A?
#- > zsh: no matches found: A?
#- $ set nonomatch
#- $ ls A?
#- > ls: A?: No such file or directory
setopt NOMATCH
#setopt NONOMATCH

# no Beep on error in ZLE.
setopt NO_BEEP

# Remove any right prompt from display when accepting a command line.
# This may be useful with terminals with other cut/paste methods.
# 移除命令返回值前的 prompt
# 如果用了 p10k，就不用设置下面这一条了
setopt TRANSIENT_RPROMPT

# If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.
# 命令补全时，从 cursor 所在处向前向后两头匹配，如果没有设置，则只会向后匹配
#- $ touch Makefile
#- $ ls Mafile (此时按 tab 键是没有反应的，因为当前目录下没有以 Mafile 开头的文件)
#- $ setopt COMPLETE_IN_WORD
#- $ ls Mafile (将 cursor 移动到 Mafile 中的 f 上，然后按 tab)
#- $ ls Makefile (Mafile 会被补全为 Makefile，因为补全也匹配了符合 ^Ma.*file$ pattern 的文件，如果目录下还有一个名为 Makkefile 的文件，也会被匹配到)
setopt COMPLETE_IN_WORD

# Make cd push the old directory onto the directory stack.
# 对 cd 前的目录调用 pushd，pushd 是一个 linux 命令，将当前目录 push 到一个栈里，类似 git stash push。成对的，有 popd
setopt AUTO_PUSHD

# Don’t push multiple copies of the same directory onto the directory stack.
# pushd 时忽略重复目录
setopt PUSHD_IGNORE_DUPS

# DON NOT Allow ‘>’ redirection to truncate existing files, and ‘>>’ to create files. Otherwise ‘>!’ or ‘>|’ must be used to truncate  a file, and ‘>>!’ or ‘>>|’ to create a file.
# > 在文件不存在时会创建文件，在文件存在时会清空文件内容并写入。设置 no_clobber 让 > 只能创建文件，不能覆写文件
# 同理，让 >> 只能用于给文件追加内容，不能用于创建文件
setopt no_clobber
