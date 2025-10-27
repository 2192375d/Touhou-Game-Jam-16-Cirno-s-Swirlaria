#!/bin/sh
printf '\033c\033]0;%s\a' cirno-project
base_path="$(dirname "$(realpath "$0")")"
"$base_path/cirno-project.x86_64" "$@"
