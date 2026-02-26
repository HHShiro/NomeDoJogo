#!/bin/sh
printf '\033c\033]0;%s\a' NomeDoJogo
base_path="$(dirname "$(realpath "$0")")"
"$base_path/O Corre.x86_64" "$@"
