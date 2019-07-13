#!/usr/bin/env bash

#
# @file
# Lorem ipsum dolar sit amet consectador.
#

# Define the configuration file relative to this script.
CONFIG="website_benchmark.core.yml";

# Uncomment this line to enable file logging.
#LOGFILE="website_benchmark.core.log"

# TODO: Event handlers and other functions go here or source another file.
function on_pre_config() {
   [[ "$(get_command)" == "init" ]] && exit_with_init
}

# Begin Cloudy Bootstrap
s="${BASH_SOURCE[0]}";while [ -h "$s" ];do dir="$(cd -P "$(dirname "$s")" && pwd)";s="$(readlink "$s")";[[ $s != /* ]] && s="$dir/$s";done;r="$(cd -P "$(dirname "$s")" && pwd)";source "$r/../../cloudy/cloudy/cloudy.sh";[[ "$ROOT" != "$r" ]] && echo "$(tput setaf 7)$(tput setab 1)Bootstrap failure, cannot load cloudy.sh$(tput sgr0)" && exit 1
# End Cloudy Bootstrap

# Input validation.
validate_input || exit_with_failure "Input validation failed."

implement_cloudy_basic

# Handle other commands.
command=$(get_command)
case $command in

    "measure")
      eval $(get_config base_url)
      has_option "base_url" && base_url=$(get_option base_url)

      eval $(get_config -a pages)
      eval $(get_config runs_per_page 5)
      eval $(get_config_path results_dir)
      exit_with_failure_if_empty_config base_url
      exit_with_failure_if_empty_config pages
      [[ "$results_dir" ]] && [ ! -d "$results_dir" ] && fail_because "The directory defined as \"results_dir\" does not yet exist; please create \"$results_dir\"."
      has_failed && exit_with_failure

      echo_title "Benchmarking: $base_url"

      yaml_clear
      yaml_add_line "base_url: $base_url"
      has_option "note" && yaml_add_line "note: $(get_option "note")"
      yaml_add_line "results:"
      for path in "${pages[@]}"; do
        url=${base_url%/}/${path%/}
        echo_heading "${path}"
        yaml_add_line "  \"$path\":"
        for (( i = 0; i < ${runs_per_page}; ++i )); do
          time=$(curl -w '%{time_total}' -o /dev/null -s $url -L)
          yaml_add_line "    - $time"
          echo "$LI $time"
        done
      done

      processed=$(php "$ROOT/helpers.php" "$(yaml_get_json)") || fail_because "Could not process raw results."

      echo_heading "Here are the processed results:"
      echo
      echo "$processed"

      if [[ "$results_dir" ]]; then
        path_to_saved="$results_dir/$(url_host $base_url)--$(date8601 -c).json"
        echo "$processed" > "$path_to_saved"
        succeed_because "Results saved: $path_to_saved"
      fi

      has_failed && exit_with_failure
      exit_with_success_elapsed
    ;;

esac

throw "Unhandled command \"$command\"."
