#!/bin/bash

confirm () {
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

clean () {
    git reset --hard
    git clean --quiet --force -d -x
    git submodule foreach git clean --quiet --force -d -x
}

confirm "Do you really want to completely clean the repository?" && clean

