#!/usr/bin/env bash
# Source: https://github.com/tardate/LittleCodingKata/tree/main/bash/image-renamer
#

function usage() {
    cat <<EOF
Usage:
  $0 <source_path> [-b base_name] [-p print_style] [-s sort_order]
  Example: $0 ./assets/sample-data -b image- -p md -s time
Options:
  <source_path>   Path to the source directory containing images.
  -b base_name    Optional stem name for the renamed files (default: "image-").
  -p print_style  Optional output style for the renamed files (default: "md").
                  Supported styles: md, html, plain.
  -s sort_order   Optional order of files to process (default: "time").
                  Supported orders: time, name.
  -h              Show this help message.

EOF
    exit 1
}

# iterate over all files in the source directory, sorted by time
# and rename using stem_name, file index, and keeping the original extension
function rename_files() {
    local index=0
    find ${source_path} -maxdepth 1 -type f | while IFS= read -r file; do
        index=$((index + 1))
        local filename=$(basename "${file}")
        local foldername=$(dirname "${file}")
        local ext="${filename##*.}"
        local new_name="${stem_name}${index}"
        local new_filename="${new_name}.${ext}"
        local new_full_path="${foldername}/${new_filename}"
        mv "${file}" "${new_full_path}"
        case "${print_style}" in
        md)
            echo "![${new_name}](${new_full_path})"
            ;;
        html)
            echo "<a href=\"${new_full_path}\">${new_name}</a>"
            ;;
        *)
            echo "${new_full_path}"
            ;;
        esac
    done
}

source_path=${1}
if [ "${source_path}" != "-h" ]; then
  shift
fi
stem_name="image-"
print_style="md"
sort="time"

while getopts "b:p:s:h" opt
do
  case $opt in
  b)
    stem_name=$OPTARG
    ;;
  p)
    print_style=$OPTARG
    ;;
  s)
    sort=$OPTARG
    ;;
  h)
    usage
    ;;
  \?)
    echo "invalid option"
    usage
    ;;
  esac
done

case "${sort}" in
time)
  ls_opt="-1rt"
  ;;
*)
  ls_opt="-1"
  ;;
esac

rename_files
