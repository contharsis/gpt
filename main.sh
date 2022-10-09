#!/bin/bash

# fix import to port to library in /usr/local/lib
source bsl/main.sh

declare gpt_folder="/home/$(whoami)/.config/gpt"
declare gpt_config="$gpt_folder/config"
declare gpt_entry="$gpt_folder/entry"

declare -a gpt_files=( "$gpt_folder" "$gpt_config" "$gpt_entry" )
declare -a gpt_file_types=( 'd' 'f' 'f' )
declare -a gpt_commands=( 'init' )

gpt_init() {
        bsl_fch "$gpt_folder" 'd'
        bsl_fch "$gpt_config" 'f' 'n'
        bsl_fch "$gpt_entry" 'f' 'n'
}

gpt() {
	declare gpt_command="$1"
	
	declare gpt_valid_command=$(bsl_fstr "${gpt_commands[*]}" "$gpt_command")
	declare gpt_missing_file=$(bsl_ifch "${gpt_files[*]}" "${gpt_file_types[*]}" 'gpt init' "gpt $gpt_command")

	if [ "$gpt_valid_command" = 'n' ]; then
		bsl_cmdnfm "$1" 'gpt help'
		return -1
	fi

	if [ "$gpt_missing_file" = 'y' ]; then
		return -2
	fi

	"gpt_$gpt_command"
}
