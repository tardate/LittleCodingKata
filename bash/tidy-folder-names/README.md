# #xxx Tidy Folder Names

A little script that can standardise the naming of a set of folders to kebab-case, snake_case, or CamelCase

## Notes

Ever want to standardise the way a set of folders are named?

The [tidy-folders.sh](./tidy-folders.sh) script does this, handling most cases.
It currently only renames folders, and ignores normal files.
Perhaps files, folders, or both should be a selection?

```sh
$ ./tidy-folders.sh . help
Usage: ./tidy-folders.sh [directory] [kebab-case|snake_case|CamelCase]
```

It uses a combination of [awk](https://man.openbsd.org/awk.1), [sed](https://man.openbsd.org/sed.1), and [tr](https://man.openbsd.org/tr.1)
to get the job done.

The core functions are implemented like this:

```bash
# Function to convert to kebab-case
to_kebab_case() {
  echo "$1" | sed -E 's/([a-z])([A-Z0-9])/\1-\2/g' | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr '_' '-'
}

# Function to convert to snake_case
to_snake_case() {
  echo "$1" | sed -E 's/([a-z])([A-Z0-9])/\1-\2/g' | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr '-' '_'
}

# Function to convert to CamelCase
to_camel_case() {
  echo "$1" | awk -F'[-_ .]' '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' OFS=''
}
```

### Testing

The [test.sh](./test.sh) runs a series of tests:

```sh
$ ./test.sh
# Given folders:
Test Folder with spaces e.g. 1
Test Folder with spaces e.g. 2
test_snake_case_folder_1
test_snake_Case_folder_2
test-kebab-case-folder-1
test-kebab-Case-folder-2
TestCamelCaseFolder1
TestCamelCaseFolder2
## All folders renamed successfully to kebab-case:
test-camel-case-folder-1
test-camel-case-folder-2
test-folder-with-spaces-e.g.-1
test-folder-with-spaces-e.g.-2
test-kebab-case-folder-1
test-kebab-case-folder-2
test-snake-case-folder-1
test-snake-case-folder-2
## All folders renamed successfully to snake_case:
test_camel_case_folder_1
test_camel_case_folder_2
test_folder_with_spaces_e.g._1
test_folder_with_spaces_e.g._2
test_kebab_case_folder_1
test_kebab_case_folder_2
test_snake_case_folder_1
test_snake_case_folder_2
## All folders renamed successfully to CamelCase:
TestCamelCaseFolder1
TestCamelCaseFolder2
TestFolderWithSpacesEG1
TestFolderWithSpacesEG2
TestKebabCaseFolder1
TestKebabCaseFolder2
TestSnakeCaseFolder1
TestSnakeCaseFolder2
```

## Credits and References

* [awk](https://man.openbsd.org/awk.1)
* [sed](https://man.openbsd.org/sed.1)
* [tr](https://man.openbsd.org/tr.1)
