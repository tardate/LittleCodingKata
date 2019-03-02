#!/bin/bash
#
# A simple script to initialise a new project
#


function usage() {
  cat <<EOF

Make a new project workspace..

Usage:
  $0 project/path

EOF
  exit
}

function make_project() {
  # full_path=Folder/Part1/Part2
  # parent_folder = Folder/Part1
  # project_name = Part2
  local full_path="${1}"
  local parent_folder=$(dirname "$full_path")
  local project_name=$(basename "$full_path")

  mkdir -p ${full_path}

  local readme_file="${full_path}/README.md"
  echo "making ${readme_file}"
  cat > "${readme_file}" <<EOS
# ${project_name}

__subtitle__

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

__notes__

## Credits and References

* [name](url)
* [..as mentioned on my blog](https://blog.tardate.com/)
EOS

  local catalog_file="${full_path}/.catalog_metadata"
  echo "making ${catalog_file}"
  cat > "${catalog_file}" <<EOS
{
    "name": "${project_name}",
    "description": "enter description",
    "categories": "${parent_folder}",
    "relative_path": "${full_path}"
}
EOS

  echo "project initialised: ${full_path}"
  open "${full_path}"
}

scriptPath=${0%/*}/
cd ${scriptPath}../
project_path=${1:-help}

case ${project_path} in

help)
  usage
  ;;

*)
  make_project "${project_path}"
  ;;

esac
