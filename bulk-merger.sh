#!/usr/bin/env bash
set -eu

cmd=$(basename "$1")
[[ -z "$*" ]] && echo 'usage: ./merger [list|merge|merge_only|review] <query_string>' && exit 64
[[ -r ".env" ]] && source .env

export QUERY_STRING="$2"
bundle exec rake "$cmd"
