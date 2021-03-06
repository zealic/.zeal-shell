: << EOF
::=========================================================
:: BEGIN BATCH
::=========================================================
@echo off
pushd "%~dp0"
if "%TERM%" EQU "" (
  powershell -File "%cd%\share\startup.ps1"
  @goto :eof
)
@bash "%~dp0\%~nx0" "%cd%" "%~dp0"
popd
@goto :eof
EOF
#!/bin/sh
#=========================================================
# BEGIN SHELL
#=========================================================
startup_os() {
  local kzsh="${(%):-%x}"
  local kbash="${BASH_SOURCE[0]}"
  local bootstrap
  local readlink=readlink
  if [ -z "$kzsh" ] && [ -z "$kbash" ]; then
    echo "Unsupported shell!"
  fi
  # for x64 version
  if [[ -f "/usr/local/opt/coreutils/libexec/gnubin/readlink" ]]; then
    readlink=/usr/local/opt/coreutils/libexec/gnubin/readlink
  fi
  # for arm universal version
  if [[ -f "/opt/homebrew/opt/coreutils/libexec/gnubin/readlink" ]]; then
    readlink=/opt/homebrew/opt/coreutils/libexec/gnubin/readlink
  fi

  if [[ ! -z "$kzsh" ]]; then
    bootstrap=$(dirname `$readlink -f "$kzsh"`)
  fi
  if [[ ! -z "$kbash" ]]; then
    bootstrap=$(dirname `$readlink -f "$kbash"`)
  fi
  export ZEALISH=$bootstrap
}

startup_os
unset -f startup_os

bootfile="$ZEALISH/system/$(uname -s | tr '[:upper:]' '[:lower:]').sh"
if [[ -f "$bootfile" ]]; then
  sh $ZEALISH/upgrade.sh
  cat $ZEALISH/LOGO.txt
  source "$bootfile"
else
  echo "Not supported system, $bootfile"
  return
fi
