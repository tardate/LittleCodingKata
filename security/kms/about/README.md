# #316 AWS KMS

About the AWS Key Management Service (KMS).

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

## Credits and References

* [AWS Key Management Service (KMS)](https://aws.amazon.com/kms/)
* [AWS Key Management Service Developer Guide](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
