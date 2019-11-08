# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

################################################################
ntpdate 192.168.0.4
cp /home/1/drives/c/south.tml/upos/pinpad.ini_work /home/1/drives/c/south.tml/upos/pinpad.ini
cd /home/1/drives/c/south.tml
#./psa_disp_uni.exe ttyUSB0 ./ &
#./psa_fr_uni.exe -yttyS &
#./psa_scan_uni.exe ttyUSB2 ./ &
#./psa_fr.exe -yS -bn &        # ������� ����������� ������������.����� COM ����� ����� ���������� ����� dmesg |grep tty 
./psa_fr_uni.exe &
#./disp_usb.exe 0 &           # ����� ����������. ���������� ����� USB-COM. �������� ����� ��� � ���� ��� ������� ��������������.
#./slim_nix.exe ttyACM1 &     # ���� ������ Slim
./digi708.exe USB0 &         # ���� ������� digi780
#./disp_video_usb.exe 0 ./ 192.168.1.150 1001 1 1 &   # ��� �������. ����� ���������� � ��������. ��� � �����.
./curl_nix.exe &
./wait_nix.exe &
./watch_proc.exe curl_nix.exe './curl_nix.exe &' &              # Open for Sberbank
#./watch_proc.exe psa_fr_usb.exe "./psa_fr_usb.exe -bn &" &
setfont CyrKoi-VGA16          # Open for Sberbank and RS
echo -ne "\033(K"             # Open for Sberbank and RS
#screen -S "dos" dosemu -k -V # ����� ����� � ������
dosemu -k -V                  # without screen

########## ������� ���������� �������� ��� ������ �� ����� ##########
#killall psa_disp_uni.exe
killall psa_fr_uni.exe
#killall psa_scan_uni.exe
#killall psa_fr.exe
#killall disp_usb.exe
#killall slim_nix.exe
killall digi708.exe
#killall disp_video_usb.exe
killall curl_nix.exe
killall wait_nix.exe          # Open for Sberbank

exit
######################################################################