#!/bin/bash

number_of_args=2
E_WRONG_ARGS=3

if [ "$1" == "-h" ] || [ "$1" == "--help" ]
then
   echo "Usage: `basename $0` username repository-name"
   exit 0
fi

if [ $# -ne $number_of_args ]
then
	echo "Usage: `basename $0` username repository-name"
	exit $E_WRONG_ARGS
fi

USER=$1
REPO=$2

curl -u "${USER}" https://api.github.com/user/repos -d '{"name":"'${REPO}'"}' ;

if [ ! -f README.md ]
then
	echo "# ${REPO}" >> README.md ;
fi

git init ;
git add README.md ;
git commit -m "Initial commit." ;
git remote add origin https://github.com/${USER}/${REPO}.git ;
git push -u origin master ;
