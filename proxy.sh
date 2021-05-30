if [[ ! -d "$HOME/.wsl2-proxy" ]]; then
    mkdir $HOME/.wsl2-proxy
fi
if [ ! -f "~/.wsl2-proxy/port" ];then
    touch ~/.wsl2-proxy/port
fi
if [ ! -f "~/.wsl2-proxy/auto.sh" ];then
    touch ~/.wsl2-proxy/auto.sh
fi
if [ $(grep -c "source ~/.wsl2-proxy/auto.sh" ~/.zshrc) -eq '0' ];then 
    echo "source ~/.wsl2-proxy/auto.sh" >> ~/.zshrc
fi

set_port(){
    echo $1 > ~/.wsl2-proxy/port
}

set_wsl_proxy(){
    export WINIP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
    export PORT=$(cat ~/.wsl2-proxy/port)
    export http_proxy=http://$WINIP:$PORT
    export ftp_proxy=http://$WINIP:$PORT
    export https_proxy=http://$WINIP:$PORT
    export all_proxy=http://$WINIP:$PORT
    export HTTP_PROXY=http://$WINIP:$PORT
    export HTTPS_PROXY=http://$WINIP:$PORT
    export FTP_PROXY=http://$WINIP:$PORT
    export ALL_PROXY=http://$WINIP:$PORT
}

unset_wsl_proxy(){
    unset http_proxy
    unset ftp_proxy
    unset https_proxy
    unset all_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset ALL_PROXY
}

register_auto_enable_proxy(){
    echo "set_wsl_proxy" > ~/.wsl2-proxy/auto.sh
}

unregister_auto_enable_proxy(){
    echo "" > ~/.wsl2-proxy/auto.sh
}

