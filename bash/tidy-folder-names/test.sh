#!/usr/bin/env bash

function make_folders() {
  rm -fR Test*
  rm -fR test*

  mkdir "Test Folder with spaces e.g. 1"
  mkdir "Test Folder with spaces e.g. 2"
  mkdir "TestCamelCaseFolder1"
  mkdir "TestCamelCaseFolder2"
  mkdir "test_snake_case_folder_1"
  mkdir "test_snake_Case_folder_2"
  mkdir "test-kebab-case-folder-1"
  mkdir "test-kebab-Case-folder-2"
  touch "test-ignore Plan_Files"
}

function test_kebab_case() {
  make_folders

  ../tidy-folders.sh . kebab-case

  # Check if the folders have been renamed correctly
  if [[ -d "test-folder-with-spaces-e.g.-1" && -d "test-folder-with-spaces-e.g.-2" && \
        -d "test-camel-case-folder-1" && -d "test-camel-case-folder-2" && \
        -d "test-snake-case-folder-1" && -d "test-snake-case-folder-2" && \
        -d "test-kebab-case-folder-1" && -d "test-kebab-case-folder-2" && -f "test-ignore Plan_Files" ]]; then
    echo "## All folders renamed successfully to kebab-case:"
  else
    echo "** Some folders were not renamed correctly **"
  fi
  ls -1
}

function test_snake_case() {
  make_folders

  ../tidy-folders.sh . snake_case

  # Check if the folders have been renamed correctly
  if [[ -d "test_folder_with_spaces_e.g._1" && -d "test_folder_with_spaces_e.g._2" && \
        -d "test_camel_case_folder_1" && -d "test_camel_case_folder_2" && \
        -d "test_snake_case_folder_1" && -d "test_snake_case_folder_2" && \
        -d "test_kebab_case_folder_1" && -d "test_kebab_case_folder_2" && -f "test-ignore Plan_Files" ]]; then
    echo "## All folders renamed successfully to snake_case:"
  else
    echo "** Some folders were not renamed correctly **"
  fi
  ls -1
}

function test_camel_case() {
  make_folders

  ../tidy-folders.sh . CamelCase
  # Check if the folders have been renamed correctly
  if [[ -d "TestFolderWithSpacesEG1" && -d "TestFolderWithSpacesEG2" && \
        -d "TestCamelCaseFolder1" && -d "TestCamelCaseFolder2" && \
        -d "TestSnakeCaseFolder1" && -d "TestSnakeCaseFolder2" && \
        -d "TestKebabCaseFolder1" && -d "TestKebabCaseFolder2" && -f "test-ignore Plan_Files" ]]; then
    echo "## All folders renamed successfully to CamelCase:"
  else
    echo "** Some folders were not renamed correctly **"
  fi
  ls -1
}

mkdir -p wip
cd wip

make_folders
echo "# Given folders:"
ls -1

test_kebab_case
test_snake_case
test_camel_case
