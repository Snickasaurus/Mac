# shellcheck disable=2148,2034

#-------------------------------------------------------------
# Random shits
#-------------------------------------------------------------
alias mountt='mount | column -t'
alias eprofile='sublime ~/.bash_profile'
alias rprofile='source ~/.bash_profile'
alias econfig='sublime ~/.ssh/config'
alias vmtool='/bin/sh $HOME/Dropbox/Scripts/Mac/vmware/vmTool.sh'
alias crazymax='/bin/sh $HOME/Dropbox/Scripts/Mac/create/hostsCrazyMax.sh'
alias whoisup='/bin/sh $HOME/Dropbox/Scripts/Mac/net/checkHostStatus.sh'

#-------------------------------------------------------------
# Move around a little easier/lazier
#-------------------------------------------------------------
alias c='clear'                             # Clear the terminal screen
alias h='cd ~'                              # Change directory to home path
alias r='cd /'                              # Change directory to root of the drive
alias f='open -a Finder ./'                 # Opens current directory in Finder
alias dbox='cd ~/Dropbox'                   # Change directory to Dropbox root
alias scripts='cd ~/Dropbox/Scripts/Mac'    # Change directory to Mac scripts folder

#-------------------------------------------------------------
# Show set system paths
#-------------------------------------------------------------
alias paths='echo -e ${PATH//:/\\n}'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
alias ll='ls -lhG'
alias la='ls -alhG'
alias lx='ls -lB'           #  Sort by extension.
alias lk='ls -lSr'          #  Sort by size, biggest last.
alias lt='ls -ltr'          #  Sort by date, most recent last.
alias lc='ls -ltcr'         #  Sort by/show change time,most recent last.
alias lu='ls -ltur'         #  Sort by/show access time,most recent last.
alias tree='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#-------------------------------------------------------------
# Open 'man' output in Preview.app
#-------------------------------------------------------------
pprint()
{
    man -t "$1" | open -f -a /Applications/Preview.app
}

#-------------------------------------------------------------
# Extraction
#-------------------------------------------------------------
extract()
{
    if [ -f "$1" ]
        then
        case $1 in
            *.tar.bz2)  tar xvjf "$1"     ;;
            *.tar.gz)   tar xvzf "$1"     ;;
            *.bz2)      bunzip2 "$1"      ;;
            *.rar)      unrar x "$1"      ;;
            *.gz)       gunzip "$1"       ;;
            *.tar)      tar xvf "$1"      ;;
            *.tbz2)     tar xvjf "$1"     ;;
            *.tgz)      tar xvzf "$1"     ;;
            *.zip)      unzip "$1"        ;;
            *.Z)        uncompress "$1"   ;;
            *.7z)       7z x "$1"         ;;
            *)          echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

#-------------------------------------------------------------
# Compression
#-------------------------------------------------------------
# Creates an archive (*.tar.gz) from given directory.
mkgz() {
    tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"
}

# Creates an archive (*.tar.bz2) from a given directory
mkbz2() {
    tar cvjSf "${1%%/}.tar.bz2" "${1%%/}/"
}

# Create a ZIP archive of a file or folder.
mkzip() {
    zip -r "${1%%/}.zip" "$1"
}

# Make your directories and files access rights sane.
sanitize() {
    chmod -R u=rwX,g=rX,o= "$@"
}

#-------------------------------------------------------------
# Backup anything you send as an argument
#-------------------------------------------------------------
backup(){
    tar -cPf - "$1" | gzip -9 - > /Volumes/Temp/"$1"-"$(date "+%Y%m%d-%H.%M.%S")".tar.gz
}

#-------------------------------------------------------------
# VMware Fusion
#-------------------------------------------------------------
if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]
then
    export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
fi

#-------------------------------------------------------------
# VMware OVF Tool
#-------------------------------------------------------------
if [ -d "/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool" ]
then
    export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool"
fi

#-------------------------------------------------------------
# SublimeText
#-------------------------------------------------------------
alias sublime='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl '

#-------------------------------------------------------------
# Networking
#-------------------------------------------------------------
alias xip='dig +short myip.opendns.com @resolver1.opendns.com'

ip()
{
    ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
}

#-------------------------------------------------------------
# Date and time incase Terminal is full screen.
#-------------------------------------------------------------
alias now='echo "------------------" && echo "Day  : `date '+%A'`" && echo "Date : `date '+%Y-%m-%d'`" && echo "Time : `date '+%H:%M'`" && echo "------------------"'

#-------------------------------------------------------------
# Convert .PLIST to xml, open with nano then convert back to binary .PLIST
#-------------------------------------------------------------
plistu()
{
    /usr/bin/plutil -convert xml1 "${1}"
    /usr/bin/nano -w "${1}"
    /usr/bin/plutil -convert binary1 "${1}"
}

#-------------------------------------------------------------
# Processes and services
#-------------------------------------------------------------
ii()
{
    echo -e "${Red}You are logged on: $NC " ; hostname
    echo " "
    echo -e "${Red}Additionnal information: $NC " ; uname -a
    echo " "
    echo -e "${Red}Users logged on: $NC " ; w -h
    echo " "
    echo -e "${Red}Current date :$NC " ; date
    echo " "
    echo -e "${Red}Machine stats: $NC " ; uptime
    echo " "
    echo -e "${Red}Internal IP Address: $NC " ; ip
    echo " "
    echo -e "${Red}Public facing IP Address: $NC " ; xip
    echo
}

#-------------------------------------------------------------
# Linux/Unix permissions
#-------------------------------------------------------------
perms(){
    echo " "
    echo -e "rwxrwxrwx = ${Red}777$NC  All can read, write & execute"
    echo -e "rwxrwxr-x = ${Green}775$NC  Owner/Group read, write & execute. Others can read, execute"
    echo -e "rwxrwxr-- = ${Yellow}774$NC  Owner/Group read, write & execute. Others can read"
    echo -e "rwxr-xr-x = ${Blue}755$NC  Owner can read, write & execute. Others can read, execute"
    echo -e "rwx------ = ${Purple}700$NC  Owner can read, write & execute. Everyone else has no rights"
    echo -e "rw-rw-rw- = ${Cyan}666$NC  Everyone can read & write"
    echo -e "rw-r--r-- = ${White}664$NC  Owner/Group read, write. Others can read"
    echo -e "rwx------ = ${Red}644$NC  Owner can read & write. Others can read"
    echo " "
}

#-------------------------------------------------------------
# Cleanup
#-------------------------------------------------------------
alias dp='rm -f ~/dwhelper/*'

#-------------------------------------------------------------
# Python shit
#-------------------------------------------------------------
# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

#-------------------------------------------------------------
# Change the text color
#-------------------------------------------------------------
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

NC='\033[0m'            # Color Reset
export PATH="/usr/local/opt/sqlite/bin:$PATH"
