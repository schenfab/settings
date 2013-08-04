
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

test -s ~/.alias && . ~/.alias || true

# Source the SCS scripts (tool licensing)
if [ -f /etc/scs-scripts/scs_settings.sh ]; then
    source /etc/scs-scripts/scs_settings.sh
fi

# Prepare SSH-Agent
SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s -t10h"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
fi

# Direct connection to X-server
#if [ ! "$SSH_CONNECTION" = "" ]; then
#    #IP=`echo $SSH_CONNECTION | cut -d' ' -f1`
#    IP=`dig +short bun-tschlin.scs-ad.scs.ch`
#    export DISPLAY="${IP}:0.0"
#fi

# Set PS1 variable
export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Colourful ls output
eval $(dircolors)
LS_COLORS=$LS_COLORS":*.vhd=00;96:*.v=00;96:*.vp=00;96:*.vh=00;96:"

# Aliases for convenience
alias ls='ls --color=auto'
alias ll='ls -hl --time-style=long-iso'
alias grep='grep --color=auto'
export BASHRC_TB="/usr/scs/fschenkel/vhdl/vhdl-lib-env/tb/vhdl-lib/synth/axi/vhdl/tb_axi4_mc/scripts"
export BASHRC_VHDL="/usr/scs/fschenkel/vhdl/vhdl-lib-env/vhdl-lib/synth/axi/vhdl"
function goto_tb   { cd $BASHRC_TB; }
function goto_vhdl { cd $BASHRC_VHDL; }
function set_tb   { sed -i "s:export BASHRC_TB=\"${BASHRC_TB}\":export BASHRC_TB=\"$(pwd)\":g" ~/.bashrc; export BASHRC_TB=$(pwd); }
function set_vhdl { sed -i "s:export BASHRC_VHDL=\"${BASHRC_VHDL}\":export BASHRC_VHDL=\"$(pwd)\":g" ~/.bashrc; export BASHRC_VHDL=$(pwd); }
alias t="goto_tb"
alias tt="set_tb"
alias v="goto_vhdl"
alias vv="set_vhdl"
alias push="git stash && git pull --rebase && git push; git stash pop"
alias pull="git stash && git pull --rebase; git stash pop"
alias e="emacs -nw"
alias emasc="emacs"
function xilinx_env { . /opt/toolchain/xilinx/Xilinx14.5i/settings64.sh; TMP=${XILINX%//ISE}; TMP=${TMP##*/}; echo -en "\033]2;$TMP\007"; }
alias x="xilinx_env"
alias m="export PATH=/opt/toolchain/modelsim/modelsim_dlx_10.0e/bin:${PATH}"
#alias m="export PATH=/opt/toolchain/modelsim/modelsim_dlx_10.2a/bin:${PATH}"
alias s="ssh-add"
[[ -x ~/sandbox/tig-1.1/tig ]]   && alias tig="~/sandbox/tig-1.1/tig --all"
[[ ! -x ~/sandbox/tig-1.1/tig ]] && alias tig="tig --all"
alias gitk="gitk --all"
alias ssh="ssh"
alias log="tail --retry --follow=name"
alias tree="tree -C"
alias gdiff="git diff --no-index"
alias uncolor="sed -i -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g'"
# Add new paths
export PATH=$PATH:"/opt/toolchain/codecomposer/ccs_5.1.1/ccsv5/eclipse/"

# 256 colors for terminal
export TERM="xterm-256color"

# Some other variables
export EDITOR="emacs -nw"
export LESS="-iRS"

# Smart bash completion
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi
