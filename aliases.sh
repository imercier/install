export EDITOR='vim'
alias in='sudo apt-get install -y'
alias out='sudo apt-get purge'
alias q='exit'
alias up='sudo apt-get update && sudo apt-get -y dist-upgrade'
alias d='wget -c'
alias c='clear'
alias cl='sudo apt-get clean;sudo apt-get -y autoremove --purge; sudo apt-get -y purge `deborphan`'
alias m='mount | column -t'
alias l='ls -lah --color'
alias sl='sudo ls -lah --color'
alias ll='ls -lah --color'
alias ht='htop'
alias df='df -h'
alias grep='grep --color'
alias v='vim -O'
alias ga='git add -A'
alias gs='git status'
alias gb='git branch -a'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdn='git diff --name-only'
alias gdv='git difftool --tool=vimdiff --no-prompt'
alias gl='git log'
alias gln='git log --name-only'
alias gll='git log --graph --oneline --decorate --all --remotes=origin'
alias gc='git checkout'
alias gp='git pull'
alias gg='git grep'
alias gcp='git cherry-pick'
alias gr='git remote -v'
alias gf='git fetch'
alias ri='repo info'
alias rs='repo sync -j8'
alias ru='repo upload'
alias ra='repo abandon'
alias rp='repo prune'
alias rd='repo diff'
alias t='tree -Ca -I ".git*" --noreport'
alias pd='qpdfview > /dev/null 2>&1'
alias lsbig='ls -lhS **/** | head'
alias ws='sudo wireshark -i eth0 -k > /dev/null 2>&1 &'
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
alias rs0='minicom -o --color=on -D /dev/ttyUSB0'
alias rs1='minicom -o --color=on -D /dev/ttyUSB1'
alias beep='aplay -q /usr/share/orage/sounds/Spo.wav > /dev/null 2>&1'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias hs='history | tail -n50'
alias br='break_reboot /dev/ttyUSB0; break_reboot /dev/ttyUSB1'
alias s='sudo !!'
alias xp='xbacklight +10'
alias xm='xbacklight -10'
alias tn='ssh -2NfCT4 -D 8080 srv'
alias trb='ssh -2NfCT4 -L 9050:127.0.0.1:9050 srv'
alias dm='sudo dmesg -cH'
alias bw='wget http://test-debit.free.fr/image.iso -O /dev/null'
alias sv='sudo vim -O'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias saveroot='sudo fsarchiver savefs -j 4 -A /media/data/info/os/sys-`date +%F`.fsa /dev/disk/by-label/root_ssd'
alias adup='sudo wget -q https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -O /etc/dnsmasq.hosts && sudo service dnsmasq force-reload'
alias sudo='sudo '
alias data2srv='duplicity /media/data/doc/ --exclude /media/data/doc/doc_old --exclude /media/data/doc/etudes/ --exclude /media/data/doc/job/ scp://srv/backup'
alias n='sudo netstat -lptnu'
alias fm='flashmodem -b $(ls -t ~/src/AGX/AGX/Out/AGX*354*.bin | head -1) -t /dev/ttymodem && screen /dev/ttymodem 115200'
alias fme='flashmodem -e -b $(ls -t ~/src/AGX/AGX/Out/AGX*354*.bin | head -1) -t /dev/ttymodem && screen /dev/ttymodem 115200'
alias svm='screen rdesktop -u i.mercier -g 1920x1024 win7'
alias natoff="sudo sh -c 'iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE && echo 0 > /proc/sys/net/ipv4/ip_forward'"
alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'

function mkc() {
	mkdir -p $1 && cd $1
}

function vd() {
	vimdiff <(xxd $1) <(xxd $2)
}

function g() {
	x-www-browser "http://google.com/search?q=$*" > /dev/null 2>&1
}

function debchange () {
	zless "/usr/share/doc/$1/changelog.Debian.gz"
}

function f () {
find -iname "*$**" -and -not -path "*.git*" 2>/dev/null | egrep -i --color "$*"
}

function un () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar -I lbzip2 -xf $1     ;;
			*.tar.gz)    tar -I pigz -xf $1     ;;
			*.tar.xz)    tar -xf $1     ;;
			*.tgz)    	 tar -I pigz -xf $1     ;;
			*.bz2)       pbzip2 -d $1   ;;
			*.rar)       unrar e $1     ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xf $1      ;;
			*.tbz2)      tar xjf $1     ;;
			*.tgz)       tar xzf $1     ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*)     echo "'$1' cannot be extracted ()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

function cz () {
	tar -I pigz -cf "`basename $1`.tar.gz" $1
}

function databackup () {
	function exit_backup() {
		echo "** Trapped CTRL-C"
		sudo umount /media/backup
	}
	#trap exit_backup INT
	sudo fsck -y /dev/disk/by-label/data_backup
	sudo mount /media/backup &&\
	rsync -av --info=progress2 --exclude 'lost+found' --exclude '.Trash-*' --delete-after /media/data/ /media/backup/ &&\
	sync &&\
	sudo umount /media/backup
}

function srvsave () {
	rsync --delete-after --rsync-path="sudo rsync" -aAX --info=progress2 --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} srv.sav:/ /media/data/info/os/srv-backup
}

function kc () {
	sudo apt-get purge $(for tag in "linux-image" "linux-headers"; do dpkg-query -W -f'${Package}\n' "$tag-[0-9]*.[0-9]*.[0-9]*" | sort -V | awk 'index($0,c){exit} //' c=$(uname -r | cut -d- -f1,2); done)
}

function vl() {
  dir=$(realpath "$1")
  editor "$dir"/$(ls -t $dir | head -1)
}

function la() {
  dir=$(realpath "$1")
  echo "$dir"/$(ls -t $dir | head -1)
}

function sms() {
  num="$1"
  msg="$2"
  curl -X POST http://pi/RaspiSMS/smsAPI/ -d "email=api@api.org&password=api&numbers=$num" --data-urlencode "text=$msg"
}

function naton() {
  if=$1
  sudo sh -c 'iptables -t nat -A POSTROUTING -o "$if" -j MASQUERADE && echo 1 > /proc/sys/net/ipv4/ip_forward'
}
  
function gls() {
  git log --all --grep="$1"
}

