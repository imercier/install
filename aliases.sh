export EDITOR='vim'
alias in='sudo apt-get install -y'
alias out='sudo apt-get purge'
alias q='exit'
alias up='sudo apt-get update && sudo apt-get -y dist-upgrade'
alias c='clear'
alias cl='sudo apt-get clean;sudo apt-get -y autoremove --purge; sudo apt-get -y purge `deborphan`'
alias m='mount | column -t'
alias l='ls -lah --color'
alias sl='sudo ls -lah --color'
alias ll='ls -lah --color'
alias h='htop'
alias df='df -h'
alias grep='grep --color'
alias v='vim -O'
alias ga='git add -A'
alias gs='git status'
alias gb='git branch'
alias gbv='git branch -avv'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdn='git diff --name-only'
alias gdv='git difftool --tool=vimdiff --no-prompt'
alias gdvc='git difftool --tool=vimdiff --no-prompt --cached'
alias gl='git log'
alias gln='git log --name-only'
alias gll='git log --graph --oneline --decorate --all --remotes=origin'
alias gp='git pull --recurse-submodules'
alias gg='git grep -i'
alias gcp='git cherry-pick'
alias gr='git remote -v'
alias gf='git fetch --all -p'
alias ri='repo info'
alias rs='repo sync -j8'
alias ru='repo upload'
alias ra='repo abandon'
alias rp='repo prune'
alias rd='repo diff'
alias t='tree -Ca -I ".git*" --noreport'
alias pd='qpdfview > /dev/null 2>&1'
alias lsbig='find . -type f -print0 | xargs -0 du -h | sort -rh | head -n 10'
alias ws='sudo wireshark -i eth0 -k > /dev/null 2>&1 &'
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
alias tn='ssh -2NfCT4q -D 8080 srv'
alias trb='ssh -2NfCT4 -L 9050:127.0.0.1:9050 srv'
alias dm='sudo dmesg -cHw'
alias bwf='wget http://test-debit.free.fr/image.iso -O /dev/null'
alias bw='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias sv='sudo vim -O'
alias saveroot='sudo fsarchiver savefs -j 4 -A /media/data/info/os/sys-`date +%F`.fsa /dev/disk/by-label/root_ssd'
alias adup='sudo wget -q https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -O /etc/dnsmasq.hosts && sudo service dnsmasq force-reload'
alias sudo='sudo '
alias n='sudo netstat -lptnu'
alias vm='VBoxManage startvm win7 --type headless'
alias si='sudo ifconfig'
alias afs='apt-file search'
alias b='watch -n1'
alias pt='ping -c1 google.de'
alias xr='xrandr --output HDMI-1 --same-as eDP-1 --output eDP-1 --mode 1920x1080'
alias cc='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias dds='sudo pkill -USR1 dd'
alias du='du -sh'

function PushDateUtc() {
  ssh $1 date -us @`( date -u +"%s" )`
}

function mkc() {
  mkdir -p $1 && cd $1
}

function vd() {
  vimdiff <(xxd $1) <(xxd $2)
}

function g() {
  x-www-browser "http://google.com/search?q=$*" > /dev/null 2>&1 &
}

function debchange () {
  zless "/usr/share/doc/$1/changelog.Debian.gz"
}

function f () {
find -type f -iname "*$**" -or -type d -iname "*$**" -and -not -path "*.git*" 2>/dev/null | egrep -i --color "$*"
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
      *.lzma)      lzma -d -k $1  ;;
      *)     echo "'$1' cannot be extracted ()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function cz () {
  tar -I pigz -cf "`basename $1`.tar.gz" $*
}

function databackup () {
  function exit_backup() {
    echo "** Trapped CTRL-C"
    sudo umount /media/backup
  }
  #trap exit_backup INT
  sudo umount /media/backup
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
  sudo iptables -t nat -A POSTROUTING -o "$1" -j MASQUERADE && echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
}

function natoff() {
  sudo iptables -t nat -D POSTROUTING -o "$1" -j MASQUERADE && echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward
}

function gls() {
  git log --all --grep="$1"
}

function ipfwd() {
  src=$1
  dst=$2
  port=$3
  sudo iptables -t nat -A PREROUTING -p tcp --dport $port -j DNAT --to-destination $dst:$port
  sudo iptables -t nat -A POSTROUTING -p tcp -d $dst --dport $port -j SNAT --to-source $src
  sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
}

function servethis() {
  IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
  echo "http://$IP:8000"
  python2.7 -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'
}

function re() {
  iface=$1
  sudo ifconfig $iface down; sudo ip addr flush dev $iface; sudo pkill dhclient; sudo dhclient -v $iface
}

function gsr() { # git search and replace recursively in text file
	old=$1
	new=$2
	git grep -I -l "$old" | xargs sed -i s@"$old"@"$new"@g
}

function gc() {
  git clone --recurse-submodules -j8 "$1" && cd "$(basename "$1" .git)"
}

function d() {
	wget -c "$1"
}

function fgg () {
	where=$1
	pattern=$2
	find -type f -iname "*$where*" -or -type d -iname "*$pattern*" -and -not -path "*.git*" 2>/dev/null | egrep -i --color "$pattern"
}

function data2srv() {
  S3M="/dev/shm/s3-drive"
  mkdir "$S3M"
  s3fs duplicity-backup "$S3M" -o uid=1000,gid=1000,umask=0007,url=https://s3-eu-west-3.amazonaws.com &&
  duplicity -vn /media/data/doc/ --exclude /media/data/doc/job/ file://"$S3M"
  fusermount -u "$S3M"
}

function createCryptPart() {
  PARTITION="$1"
  LABEL="$2"
  sudo cryptsetup luksFormat "$PARTITION" --label="$LABEL"
  sudo cryptsetup luksOpen "$PARTITION" "$LABEL"
  sudo mkfs.ext4 -L "$LABEL" /dev/mapper/"$LABEL"
  sudo tune2fs -m0 /dev/disk/by-label/"$LABEL"
  sudo cryptsetup luksClose "$LABEL"
}

