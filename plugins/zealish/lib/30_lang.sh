# Golang
export GOPATH=~/.go
path+=(
  ~/.go/bin
)

# Java
export JAVA_HOME=/Library/Java/Home
if [[ -d "/usr/local/opt/groovy/libexec" ]]; then
  export GROOVY_HOME=/usr/local/opt/groovy/libexec
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion