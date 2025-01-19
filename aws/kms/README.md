# #316 AWS KMS

About the AWS Key Management Service (KMS), with CLI example of data encrypt/decrypt with symmetric keys.

## Notes

The [AWS Key Management Service (KMS)](https://aws.amazon.com/kms/)
is used to create and control keys used to encrypt or digitally sign data.

* Fully integrated with IAM for authorization
* AWS manages the encryption keys
* CloudTrail can be used to audit KMS Key usage
* Integrated with most AWS services (EBS, S3, etc)

### Types of KMS Keys

* AWS Owned Keys (free): SSE-S3, SSE-SQS, SSE-DDB ()
* AWS Managed Key: free (aws/service-name, example: aws/rds or aws/ebs)
* Customer managed keys created or imported into KMS (not free)
* Customer managed keys imported: $1 / month

Note: API calls to KMS are not free

### Supported Keys Types

* Symmetric (AES-256 keys)
    * Single encryption key used to Encrypt and Decrypt
    * Integrated AWS services use Symmetric CMKs
    * Never get access to the unencrypted KMS Key (used via KMS API)
* Asymmetric (RSA & ECC key pairs)
    * Public (Encrypt) and Private Key (Decrypt) pair
    * For Encrypt/Decrypt and Sign/Verify operations
    * The public key is downloadable, but can’t access the unencrypted Private Key

### Automatic Key rotation

* AWS-managed KMS Key: automatic every 1 year
* Customer-managed KMS Key: (must be enabled) automatic & on-demand
* Imported KMS Key: only manual rotation possible using alias

### KMS Key Policies

* Default KMS Key Policy:
    * Created if you don’t provide a specific KMS Key Policy
    * Complete access to the key to the root user = entire AWS account
* Custom KMS Key Policy:
    * Define users, roles that can access the KMS key
    * Define who can administer the key
    * Useful for cross-account access of your KMS key

## Example KMS Scenario 1: Symmetric Key Encrypt/Decrypt

Using a customer-managed symmetric key to encrypt and decrypt data.
I am using the AWS CLI on macOS for this example:

    $ aws --version
    aws-cli/2.15.6 Python/3.11.6 Darwin/24.2.0 exe/x86_64 prompt/off

### Step 1: Create the key with the AWS console

I am creating this with a user that has full admin rights (not a root user)

* Key type: Symmetric
* Key usage: Encrypt and decrypt
* Key material origin: KMS
* Regionality: single-region key
* Alias (optional): `lck-demo-1`
* Default key policy:

      {
        "Id": "key-consolepolicy-3",
        "Version": "2012-10-17",
        "Statement": [
          {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
              "AWS": "arn:aws:iam::{my-account-id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
          }
        ]
      }

### Step 2: Encrypt The Data

I have one of Shakespeare's sonnets in [sonnet106.txt](./sonnet106.txt) that I'll be using for the encryption demo.

See: [AWS CLI Command reference: kms encrypt](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/kms/encrypt.html)

The basic command form:

    aws kms encrypt \
      --profile profile-name \ # provide a profile if the default is not the desired AWS profile to use
      --key-id alias/key-alias \ # specify the key by ID or alias
      --plaintext fileb://sonnet106.txt \ # data can be provided inline, or by file reference
      --output text --query CiphertextBlob \ # output filter. Can't find doc for this, but seems CiphertextBlob is required for symmetric key encryption
      --region ap-southeast-1 \ # specify the region of the key
      > sonnet106-encrypted.base64

The encrypted output will be base64-encoded when obtained via the AWS CLI

### Step 3: Encrypted Data Base64 Decode to Binary

    cat sonnet106-encrypted.base64 | base64 --decode > sonnet106-encrypted.bin

### Step 4: Decrypt the Binary File

See: [AWS CLI Command reference: kms decrypt](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/kms/decrypt.html)

The basic command form:

    aws kms decrypt \
      --profile profile-name \ # provide a profile if the default is not the desired AWS profile to use
      --key-id alias/key-alias \ # specify the key by ID or alias
      --ciphertext-blob fileb://sonnet106-encrypted.bin \ # data can be provided inline, or by file reference
      --output text --query Plaintext \ # output filter
      --region ap-southeast-1 \ # specify the region of the key
      > sonnet106-decrypted.base64

The decrypted data will be in base64 when obtained via the AWS CLI.

### Step 5: Decrypted Data Base64 Decode to Plain Text

    cat sonnet106-decrypted.base64 | base64 --decode > sonnet106-decrypted.txt

### Step 6: Verify The Decrypted Data Matches the Input

A quick verification with [cmp](https://man7.org/linux/man-pages/man1/cmp.1.html) (compare two files byte by byte):

    cmp -s sonnet106.txt sonnet106-decrypted.txt

### Scripted Example

The [demo_encrypt_decrpyt.sh](./demo_encrypt_decrpyt.sh) runs a full encryption-decryption cycle with verification.

Here's a test run:

    $ ./demo_encrypt_decrpyt.sh sonnet106.txt
    Source file name: sonnet106.txt
    Source file base name: sonnet106
    Using profile: paul-admin
    Using KEY_ID: alias/lck-demo-1
    -------------------
    Source file (plain text):
    Sonnet 106

    When in the chronicle of wasted time
    I see descriptions of the fairest wights,
    And beauty making beautiful old rhyme
    In praise of ladies dead, and lovely knights,
    Then, in the blazon of sweet beauty’s best,
    Of hand, of foot, of lip, of eye, of brow,
    I see their antique pen would have express’d
    Even such a beauty as you master now.
    So all their praises are but prophecies
    Of this our time, all you prefiguring;
    And, for they look’d but with divining eyes,
    They had not skill enough your worth to sing:
    For we, which now behold these present days,
    Had eyes to wonder, but lack tongues to praise.
    -------------------
    Encrypt sonnet106.txt and save the output (base64 encoded) to sonnet106-encrypted.base64
    -------------------
    Encrypted file (base64):
    AQICAHiaPVIzLQCWxqlVLQ+Pm5qM7V8MseF0n50WwBI4BZD1GwE3Pjn+ywEhFfQvBWq28xXbAAACzjCCAsoGCSqGSIb3DQEHBqCCArswggK3AgEAMIICsAYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAyQ7ggWqJ8pGyMLErcCARCAggKB9ZJQko/lOZEkVRIFcQI4xGMG5SIOyLUVFLB6RDP2VWbztaL9MfS3GKLrAFMPehVDUpKiU/7ih31gUFr/NlIbT28qGFhYw44axHz8gjfaAAD+KIb6sXOQmDaqTaPXmbe7K8pJI+TO50buo6I123MhCcv2rsitHJivx6NC8QneV+U1Br4Yd25w63Gu7EX+feUqBMSS+0aJbM71Tznx/hGs4nMd+4aXh9Etc1ZHfFf3e/XLIWVE1IApxSKHroW1XpTTanmukUyp/ZQYBToay0eZMe/itUbx5Rq2WNxd98wMmBg8XAAKDQPOk8iGYspOeyAj54WdEt6TKzKrArqfsP+acc2/xvpI4K+ArZdALT92Jwna9iICp4QuDXNqQOvejLaULEKVqJOqXJZ9iR+p0GpT62Oz9BvUH6ERckX3Z8fLae3lu0EvHB97oItmN0qQx51X8suIrS44T6YM/cqIZySlOPy/An85SGCA0843XH5q3t6bI1GI7pPoF6ACQ+x9Q8Jn2mE0FpWdpCaz79EB+A/ntIlSx9kEGr0Ht7v/APAa4It2zuwrSM/UOwzpFE+kixcDh4CaXQZnU+3Vx0fxl60hf6tafcVv9CfcasVm4jUAcF4JtfCLea9lCV+49cl16QP/gid/2i12hhd637s9z1BZbxfpqOmT57xA7I+rNvgRjno6/1FxtxFaXCvC6kk4Oln/OdoC+3VyfsaNIHaQaHjvCaBshlrZTu3pTbmii4SrCDXCWe0mtPqtwCw+x+7ATyv6atJQQxIHygSeEo2UqgVenv9t1UHlG62TfcvWJCTBdZ7AoEBaMW9K9TDmeqlx4+2uei0lHloKu2tVyxnCy56TLns=
    -------------------
    Base64 Decode sonnet106-encrypted.base64 and save the output to sonnet106-encrypted.bin
    -------------------
    Decrypt sonnet106-encrypted.bin and save the output (base64 encoded) to sonnet106-decrypted.base64
    -------------------
    Decrypted file (base64):
    U29ubmV0IDEwNgoKV2hlbiBpbiB0aGUgY2hyb25pY2xlIG9mIHdhc3RlZCB0aW1lCkkgc2VlIGRlc2NyaXB0aW9ucyBvZiB0aGUgZmFpcmVzdCB3aWdodHMsCkFuZCBiZWF1dHkgbWFraW5nIGJlYXV0aWZ1bCBvbGQgcmh5bWUKSW4gcHJhaXNlIG9mIGxhZGllcyBkZWFkLCBhbmQgbG92ZWx5IGtuaWdodHMsClRoZW4sIGluIHRoZSBibGF6b24gb2Ygc3dlZXQgYmVhdXR54oCZcyBiZXN0LApPZiBoYW5kLCBvZiBmb290LCBvZiBsaXAsIG9mIGV5ZSwgb2YgYnJvdywKSSBzZWUgdGhlaXIgYW50aXF1ZSBwZW4gd291bGQgaGF2ZSBleHByZXNz4oCZZApFdmVuIHN1Y2ggYSBiZWF1dHkgYXMgeW91IG1hc3RlciBub3cuClNvIGFsbCB0aGVpciBwcmFpc2VzIGFyZSBidXQgcHJvcGhlY2llcwpPZiB0aGlzIG91ciB0aW1lLCBhbGwgeW91IHByZWZpZ3VyaW5nOwpBbmQsIGZvciB0aGV5IGxvb2vigJlkIGJ1dCB3aXRoIGRpdmluaW5nIGV5ZXMsClRoZXkgaGFkIG5vdCBza2lsbCBlbm91Z2ggeW91ciB3b3J0aCB0byBzaW5nOgpGb3Igd2UsIHdoaWNoIG5vdyBiZWhvbGQgdGhlc2UgcHJlc2VudCBkYXlzLApIYWQgZXllcyB0byB3b25kZXIsIGJ1dCBsYWNrIHRvbmd1ZXMgdG8gcHJhaXNlLgo=
    -------------------
    Base64 Decode sonnet106-decrypted.base64 and save the output to sonnet106-decrypted.txt
    -------------------
    -------------------
    Decrypted file (plain text):
    Sonnet 106

    When in the chronicle of wasted time
    I see descriptions of the fairest wights,
    And beauty making beautiful old rhyme
    In praise of ladies dead, and lovely knights,
    Then, in the blazon of sweet beauty’s best,
    Of hand, of foot, of lip, of eye, of brow,
    I see their antique pen would have express’d
    Even such a beauty as you master now.
    So all their praises are but prophecies
    Of this our time, all you prefiguring;
    And, for they look’d but with divining eyes,
    They had not skill enough your worth to sing:
    For we, which now behold these present days,
    Had eyes to wonder, but lack tongues to praise.
    -------------------
    Verification successful: sonnet106.txt and sonnet106-decrypted.txt have the same content.

All good!

### Cleaning Up Keys

Customer-managed keys cannot be immediately deleted. They must be scheduled for deletion (with a delay of 7-30 days).
As any encrypted data will be unusable after key deletion, this provide an opportunity to cancel the deletion before it is performed.

## Credits and References

* [AWS Key Management Service (KMS)](https://aws.amazon.com/kms/)
* [KMS](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
