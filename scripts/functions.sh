#!/usr/bin/env bash

function printHeader
{
    echo "--------------------------------------------------------"
    echo " $1"
    echo "--------------------------------------------------------"
}

function printError
{
	echo "✘ $1" 1>&2

}

function printSuccess
{
	echo "✔ $1"
}

function checkIsInstaled
{
	PKG=$1
	if dpkg --get-selections | grep -w "^$PKG[[:space:]]*install$" >/dev/null ; then
    echo "true"
  fi
  echo "false"
}
