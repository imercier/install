#! /bin/bash
export EDITOR='vim'
alias in='sudo apt-get install -y'
alias out='sudo apt-get purge'
alias up='sudo apt-get update && sudo apt-get -y dist-upgrade'
alias cl='sudo apt-get clean; sudo apt-get -y autoremove --purge; sudo apt-get -y purge `deborphan`'
alias afs='apt-file search'
alias q='exit'
alias c='clear'
alias m='mount | column -t'
alias l='ls -lah --color'
alias sl='sudo ls -lah --color'
alias ll='ls -lah --color'
alias lsbig='find . -type f -print0 | xargs -0 du -h | sort -rh | head -n 30'
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
#alias gt='git log --tags --simplify-by-decoration --pretty='format:%ci %d'
alias t='tree -Ca -I ".git*" --noreport'
alias st='sudo tree -Ca -I ".git*" --noreport'
alias pd='qpdfview > /dev/null 2>&1'
alias beep='aplay -q /usr/share/sounds/sound-icons/canary-long.wav > /dev/null 2>&1'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias hs='history | tail -n50'
alias br='break_reboot /dev/ttyUSB0; break_reboot /dev/ttyUSB1'
alias s='sudo !!'
alias xp='xbacklight +10'
alias xm='xbacklight -10'
alias tn='ssh -2NfCT4q -D 8080 oraclevm'
alias trb='ssh -2NfCT4 -L 9050:127.0.0.1:9050 vm'
alias dm='sudo dmesg -cHw'
alias bwf='wget http://test-debit.free.fr/image.iso -O /dev/null'
alias bw='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias sv='sudo vim -O'
alias adup='sudo wget -q https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -O /etc/dnsmasq.hosts && sudo service dnsmasq force-reload'
alias sudo='sudo '
alias n='sudo netstat -lptnu'
alias si='sudo ifconfig'
alias b='watch -n1'
alias pt='ping -c1 google.de'
alias xr='xrandr --output HDMI-1 --same-as eDP-1 --output eDP-1 --mode 1920x1080'
alias cc='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias dds='sudo pkill -USR1 dd'
alias du='du -sh'
alias xc='xclip -sel c <'
alias tap='arecord -f S16_LE -c1 -r22050 -t raw | oggenc - -r -C 1 -R 22050 -o ~/tmp/rec_$(date +%Y-%m-%d_%H:%M:%S).ogg'
alias xp='xclip -selection clipboard -o >'
alias jj='python3 -m json.tool'
alias va='vim -O $HOME/.aws/config'
alias dc='docker rm $(docker ps -a -f status=exited -q); docker volume prune -f'

function PushDateUtc() {
  ssh "$1" date -us @`( date -u +"%s" )`
}

function mkc() {
  mkdir -p "$1" && cd "$1"
}

function vdb() {
  vimdiff <(xxd "$1") <(xxd "$2")
}

function vds() {
  vimdiff <(sort "$1") <(sort "$2")
}

function g() {
  x-www-browser "http://google.com/search?q=$*" > /dev/null 2>&1 &
}

function gus() {
  x-www-browser "http://google.com/search?gl=us&hl=en&q=$*" > /dev/null 2>&1 &
}

function debchange () {
  zless "/usr/share/doc/$1/changelog.Debian.gz"
}

function f () {
  find -type f -iname "*$**" -or -type d -iname "*$**" -and -not -path "*.git*" 2>/dev/null | egrep -i --color "$*"
}

function fd () {
  find -type d -iname "*$**" -or -type d -iname "*$**" -and -not -path "*.git*" 2>/dev/null | egrep -i --color "$*"
}

function un () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar -I lbzip2 -xf "$1"     ;;
      *.tar.gz)    tar -I pigz -xf "$1"     ;;
      *.tar.xz)    tar -xf "$1"     ;;
      *.tgz)    	 tar -I pigz -xf "$1"     ;;
      *.bz2)       pbzip2 -d "$1"   ;;
      *.rar)       unrar e "$1"     ;;
      *.gz)        unpigz "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *.lzma)      lzma -d -k "$1"  ;;
      *.lz)        lzip -d -k "$1"  ;;
      *)     echo "'$1' cannot be extracted ()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function cz () {
  tar -I pigz -cf "`basename "$1"`.tar.gz" "$*"
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
  PORT=$1
  IP=$(hostname -I | cut -f 1 -d " ")
  if [[ -z "$PORT" ]]
  then
    echo "http://$IP:8000"
    python3 -m http.server
  else
    echo "http://$IP:$PORT"
    python3 -m http.server $PORT
  fi
}

function re() {
  iface=$1
  sudo ifconfig $iface down; sudo ip addr flush dev $iface; sudo pkill dhclient; sudo dhclient -v $iface
}

function gsr() { # git search and replace recursively in text file
	old=$1
	new=$2
	git grep -I -l "$old" | xargs sed -i s@"$old"@"$new"@g # FIXME with special characters
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

function createCryptPart() {
  PARTITION="$1"
  LABEL="$2"
  sudo cryptsetup -q luksFormat "$PARTITION" --label="$LABEL"
  sudo cryptsetup luksOpen "$PARTITION" "$LABEL"
  sudo mkfs.ext4 -L "$LABEL" /dev/mapper/"$LABEL"
  sudo tune2fs -m0 /dev/disk/by-label/"$LABEL"
  sudo cryptsetup luksClose "$LABEL"
}

function lslast() {
  find -type f -print0 | xargs -0 stat --format='%Y :%y %n' | sort -nr | cut -d: -f2- | head
}

function pdlight() {
  ORIGFILE="$1"
  NEWFILE="${ORIGFILE%.*}-light.pdf"
  /usr/bin/gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -q -o "$NEWFILE" "$ORIGFILE"
}

function shadir() {
  [[ -z "$1" ]] && DIR=$PWD || DIR=$(realpath $1)
  find "$DIR" -type f -print0 | sort -z | xargs -0 shasum | shasum | head -c 40
}

function timestamp() {
    eval $(printf "%q " "$@")| ts '[%Y-%m-%d %H:%M:%S]'
}

function usbfat() {
  DEV="$1"
  if grep "$DEV" /proc/mounts > /dev/null; then
    echo "Already mount"
    return
  else
  set -e
  sudo parted "$DEV" --script -- mklabel msdos
  sudo parted "$DEV" --script -- mkpart primary fat32 0% 100%
  sudo mkfs.vfat -n "MYFAT" "$DEV"1
  set +e
  fi
}

function s3publish() {
  FILEWITHPATH=$1
  FILENAME=$(basename $FILEWITHPATH)
  EXPIREDAY=7
  EXPIRESEC=$(( $EXPIREDAY * 24 * 3600 ))
  PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c10)
  export AWS_PROFILE=cma_sandbox_poweruser
  BUCKET="s3://mi-share"
  ARCHIVEDIR="/tmp"
  ARCHIVENAME=$FILENAME.zip
  ARCHIVE=$ARCHIVEDIR/$ARCHIVENAME
  zip -q -r -P $PASSWORD $ARCHIVE $FILEWITHPATH && \
  aws s3 --only-show-errors cp $ARCHIVE $BUCKET && \
  aws s3 presign $BUCKET/$ARCHIVENAME --expires $EXPIRESEC && \
  echo "Archive password: \"$PASSWORD\", available $EXPIREDAY days"
  rm -f $ARCHIVE 2>/dev/null
}

function rd() {
  curl -s "http://127.0.0.1:13007$1" | jq
}

function ap() {
  export AWS_DEFAULT_PROFILE=$1
}

function jwtd() {
  jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< "$1"
}

function afd() {
  aws sts decode-authorization-message --encoded-message "$1" --query DecodedMessage --output text | jq '.'
}


function adup() {
  sudo wget -q https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -O /etc/dnsmasq.hosts
  sudo wget -q https://github.com/notracking/hosts-blocklists/raw/master/dnsmasq/dnsmasq.blacklist.txt -O /etc/dnsmasq.more.conf
  sudo service dnsmasq force-reload
}
