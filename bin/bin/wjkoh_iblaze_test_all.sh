#!/bin/bash

# Convert the command-line arguments to an array using parentheses and double
# quotes.
input_dirs=("$@")

# Convert the output of realpath to an array using parentheses.
rel_input_dirs=($(realpath --relative-to=. ${input_dirs[@]}))

# Add a suffix toe each element of the given array.
rel_input_dir_patterns=(${rel_input_dirs[@]/%/:all})

printf "* Project Directories to test: \n"
for i in "${!rel_input_dir_patterns[@]}"; do
  printf "  %s: %s\n" "$i" "${rel_input_dir_patterns[$i]}"
done
printf "\n"

~/bin/wjkoh_iblaze.sh test --build_tests_only \
  $(blaze query "kind(\"(cc_|py_).*test rule\", set(${rel_input_dir_patterns[@]}))")
