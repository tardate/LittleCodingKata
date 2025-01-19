#!/usr/bin/env bash


source_file="$1"
if [ -z "${source_file}" ]; then
  echo "Error: No filename provided."
  echo "Usage: $0 file-to-encrypt"
  exit 1
fi
echo "Source file name: ${source_file}"

base_name="${source_file%.*}"
echo "Source file base name: ${base_name}"

if [ -z "${AWS_PROFILE}" ]; then
  profile_part=""
else
  profile_part="--profile ${AWS_PROFILE}"
  echo "Using profile: ${AWS_PROFILE}"
fi

KEY_ID=${KEY_ID:-alias/lck-demo-1}
echo "Using KEY_ID: ${KEY_ID}"

encrypted_file="${base_name}-encrypted.base64"

echo "-------------------"
echo "Source file (plain text):"
cat ${source_file}
echo "-------------------"

echo "Encrypt ${source_file} and save the output (base64 encoded) to ${encrypted_file}"
aws kms encrypt ${profile_part} --key-id ${KEY_ID} --plaintext fileb://${source_file} --output text --query CiphertextBlob --region ap-southeast-1 > ${encrypted_file}

echo "-------------------"
echo "Encrypted file (base64):"
cat ${encrypted_file}
echo "-------------------"

encrypted_bin_file="${base_name}-encrypted.bin"

echo "Base64 Decode ${encrypted_file} and save the output to ${encrypted_bin_file}"
cat ${encrypted_file} | base64 --decode > ${encrypted_bin_file}
echo "-------------------"

decrypted_file="${base_name}-decrypted.base64"

echo "Decrypt ${encrypted_bin_file} and save the output (base64 encoded) to ${decrypted_file}"
aws kms decrypt ${profile_part} --key-id ${KEY_ID} --ciphertext-blob fileb://${encrypted_bin_file} --output text --query Plaintext --region ap-southeast-1 > ${decrypted_file}

echo "-------------------"
echo "Decrypted file (base64):"
cat ${decrypted_file}
echo "-------------------"

decrypted_text_file="${base_name}-decrypted.txt"

echo "Base64 Decode ${decrypted_file} and save the output to ${decrypted_text_file}"
cat ${decrypted_file} | base64 --decode > ${decrypted_text_file}
echo "-------------------"

echo "-------------------"
echo "Decrypted file (plain text):"
cat ${decrypted_text_file}
echo "-------------------"

if cmp -s "${source_file}" "${decrypted_text_file}"; then
  echo "Verification successful: ${source_file} and ${decrypted_text_file} have the same content."
else
  echo "Verification failed: ${source_file} and ${decrypted_text_file} do not have the same content."
fi
