# shell options as history size, keyindings, etc

# ZSH options are case insensitive, and all underscore are ignored.
# For example, `allexport`is equivalent to `A__lleXP_ort`

# Sections:
# - Key Bind
# - Auto Completion
# - History Setting
# - Changing Directories
# - Debug

# ***************************************************************************
# * Key Bind
# ***************************************************************************

# ***************************************************************************
# * Auto Completion
# ***************************************************************************
# Only regenerate completion cache once per day
autoload -Uz compinit
# Check if .zcompdump is older than 24 hours - simpler approach
if [[ -f ~/.zcompdump && $(date +'%j') != $(date -r ~/.zcompdump +'%j' 2>/dev/null || echo 0) ]]; then
	compinit
else
	compinit -C
fi

# >ls D
# Desktop/  Documents/  Downloads/ # 阻塞在这里等待进一步输入
#
# 如果 unsetopt 了:
# >ls D
# >Desktop/  Documents/  Downloads/ # 先返回所有匹配项，然后等待进一步输入
# >ls D
setopt ALWAYS_LAST_PROMPT

# Move cursor to the end of a completed word
setopt always_to_end

# >ls D
# Desktop/  Documents/  Downloads/ # 将列出所有匹配项，然后等待进一步输入
#
# 如果 unsetopt 了:
# >ls D # 继续按 tab 会在这一行不停轮换匹配项，不会在新的一行列出所有匹配项
# Automatically list choices on ambiguous completion
setopt auto_list

# 多次按 tab 是自动轮换匹配项
# 如果 unsetopt 了:
# >ls D # 继续按 tab 没有反应
# Show completion menu on a successive tab press
setopt auto_menu

# If completed parameter is a directory, add a trailing slash instead of a space
setopt auto_param_slash

# Typing `cd /usr/local/<SPACE>` will change to `cd /usr/local `.
setopt AUTO_REMOVE_SLASH

# Complete from both ends of a word
setopt complete_in_word

# setopt GLOB_COMPLETE
# Typing `ls *.c<TAB>` will cycle through matching `.c` files.

# Don't autoselect the first completion entry
unsetopt menu_complete

# ***************************************************************************
# * History Setting
# ***************************************************************************

# History Settings (big history for use with many open shells and no dups)
# Different History files for root and standard user
if ((!EUID)); then
	# Set History for root user
	HISTFILE=$ZSH_CACHE/history_root
else
	# Set History for standard user
	HISTFILE=$ZSH_CACHE/history
fi

# This option controls whether the command history is saved when you exit the shell.
# By default, it is turned on. You can disable it using setopt no_history.
SAVEHIST=10000
# This option defines the number of commands that are stored in the history. The default value is 2000.
HISTSIZE=12000

# If this is set, zsh sessions will append their history list to the history file, rather than replace it.
# Thus, multiple parallel zsh sessions will all have the new entries from their history lists added to the history file,
# in the order that they exit.
setopt append_history

# Save each command’s beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file
# setopt extended_history

# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate to be lost before losing a unique event from the list.
setopt HIST_EXPIRE_DUPS_FIRST

# When searching for history entries in the line editor, do not display duplicates of a line previously found,
# even if the duplicates are not contiguous.
setopt HIST_FIND_NO_DUPS

# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous event).
setopt hist_ignore_all_dups

#  Ignores commands that start with a space from being added to the history.
setopt hist_ignore_space

# Do not enter command lines into the history list if they are duplicates of the previous event.
setopt hist_ignore_dups

# Remove superfluous blanks from each command line being added to the history list.
setopt HIST_REDUCE_BLANKS

# When writing out the history file, older commands that duplicate newer ones are omitted.
setopt HIST_SAVE_NO_DUPS

# This option works like APPEND_HISTORY except that new history lines are added to the $HISTFILE incrementally (as soon as they are entered),
# rather than waiting until the shell exits.
# 可以使得多个 shell 之间的 history 尽可能实时同步
setopt INC_APPEND_HISTORY

# Shares the command history across multiple zsh sessions,
# allowing you to access previously executed commands from any terminal.
setopt share_history

# ***************************************************************************
# * Changing Directories
# ***************************************************************************

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

# Makes the shell notify you immediately when a background job completes.
setopt NOTIFY

# Allows the use of backticks in single-quoted strings. For example, echo 'This is a backtick: `'
setopt RC_QUOTES

# ***************************************************************************
# * Debug
# ***************************************************************************

# 启动 zsh 时打印 zsh 加载的配置文件
# setopt SOURCE_TRACE
