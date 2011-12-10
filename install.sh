#!/bin/bash

function link {
    source="${PWD}/$1"
    target="${HOME}/.$1"

    if diff ${source} ${target} > /dev/null; then
        echo "${source} is up-to-date"
    elif [ ! -e $target ]; then
        ln -sf $source $target
        echo "${source} has been created"
    else
        mv $target $target.bak
        ln -sf $source $target
        echo "${source} has been updated"
    fi
}

for file in $PWD/*
do
    if [ ! "${file##/*/}" == "Makefile" -a ! "${file##/*/}" == "install.sh" ]; then
        link ${file##/*/}
    fi
done
