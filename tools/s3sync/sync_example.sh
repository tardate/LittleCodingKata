#!/bin/bash
#

bucket=${1:-backup.example.lck.com}
source_folder=backup_example_folder
clone_folder=backup_example_folder_clone

function prompt_go() {
  local msg=$1
  read -p "${msg} Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Running.."
    return
  fi
  exit
}

function failbail() {
  local rc=$1
  if [ ${rc} -ne 0 ]
  then
    echo "!! Last command failed with error code ${rc}, bailing out now..."
    exit
  fi
}

function usage() {
  cat <<EOF

This script demonstrates some s3 sync procedures.

THIS IS DESTRUCTIVE:

* it recreates the AWS S3 bucket: ${bucket}
* it recreates the local folder: ${source_folder}
* it recreates the local folder: ${clone_folder}

For S3 commands it will use the AWS_PROFILE=${AWS_PROFILE}

EOF
  prompt_go "About to proceed .."
}

function is_bucket_readable() {
  aws s3 ls s3://${bucket} > /dev/null 2>&1
  return $?
}
function ls_bucket() {
  local msg=$1
  echo "## Listing s3://${bucket}.. ${msg}"
  aws s3 ls s3://${bucket} --recursive
  failbail $?
}

function sync_bucket() {
  local args=$1
  echo "## Sync ${source_folder} to s3://${bucket} ${args}.."
  aws s3 sync ${source_folder} s3://${bucket}/${source_folder} ${args}
  failbail $?
}


usage


# aws s3 ls s3://${bucket} > /dev/null 2>&1
is_bucket_readable
if [ $? -ne 0 ]
then
  echo "Looks like s3://${bucket} does not exist yet."
else
  echo "Looks like s3://${bucket} already exists, so removing it..."
  aws s3 rb s3://${bucket} --force
  failbail $?
fi

echo "## Creating s3://${bucket}"
aws s3 mb s3://${bucket}
failbail $?
sleep 1  # give S3 a moment to register the new bucket, else following commands may fail
aws s3api put-public-access-block --bucket ${bucket} --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
failbail $?

./create_backup_example_folder.sh

echo "## Performing initial sync.."

sync_bucket
ls_bucket


echo "## Making some local file modifications.."
rm backup_example_folder/test3.txt
echo "modification" >> backup_example_folder/test2.txt
echo "new file" > backup_example_folder/test4.txt

sync_bucket
ls_bucket "contains additions and modifications, but not deletions (yet)"


echo "## Making some more local file modifications.."
echo "another modification" >> backup_example_folder/test2.txt
echo "another new file" > backup_example_folder/test5.txt
rm backup_example_folder/docs/doc2.txt

sync_bucket "--delete"
ls_bucket "now contains additions, modifications and deletions"

echo "## Cloning S3 Bucket to local ${clone_folder}.."
if [ -d ${clone_folder} ]
then
  echo "Removing existing ${clone_folder}"
  rm -fR ${clone_folder}
fi
sleep 1  # give S3 a moment tocatch up with changes, else following commands may partially fail
aws s3 sync s3://${bucket}/${source_folder} ${clone_folder}
failbail $?
