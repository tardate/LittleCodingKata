# #058

Using Amazon S3 or Wasabi for offsite data backup and long term storage.

## Notes

Since 2006, services like [Jungle Disk](https://en.wikipedia.org/wiki/Jungle_Disk)
have been using cloud storage/AWS S3 for disck backup or mirroring.

And there are always new services coming online, like [Wasabi Hot Backup](https://wasabi.com).

But how easy is it to cobble together a cloud storage solution with shell scripts? Actually, pretty easy.

## Custom S3 Sync

This recipe is for a custom sync script that will backup a local file system to Amazon AWS S3 using the
[AWS CLI tools](https://docs.aws.amazon.com/cli/latest/reference/).
It assumes one has already [signed up for AWS](https://aws.amazon.com/console/).

### Accounts

I created a user account in [IAM](https://console.aws.amazon.com/iam/home) that will specifically be for performing the backup.

* added it to a group with AmazonS3FullAccess permissions - this could be tightened up in a real scenario
* created an Access key for the account - let's call it "MYKEY" with a secret of "MYKEYSECRET" for the purposes of these notes

### Installing the AWS CLI Tools

Given a functional python installation, the [AWS CLI tools](https://docs.aws.amazon.com/cli/latest/reference/) are easily installed with pip:

    $ pip install awscli
    $ aws --version
    aws-cli/1.16.63 Python/2.7.15 Darwin/17.7.0 botocore/1.12.53

### Credentials

The AWS CLI need some credentials. These are actual stored in the clear on disk in `~/.aws`,
so be sure they are protected, and cleared when no longer needed.

The `aws configure` command will prompt for credentials to be generated and obtained from the AWS console.

It is probably useful to setup a few different profiles (credential sets).
Since I've got a particular user account and access key I want to use for backups, it makes sense to create a custom profile
specifically for this purpose e.g. `backup`:

    $ aws configure --profile backup
    AWS Access Key ID [None]: MYKEY
    AWS Secret Access Key [None]: MYKEYSECRET
    Default region name [None]:
    Default output format [None]:

### S3 Commands

See the [Online Help](https://docs.aws.amazon.com/cli/latest/userguide/using-s3-commands.html) or run `aws s3 help`
to find out more about the available commands.

To make sure we use the right credentials, the profile must be indicated with each command e.g.

    aws s3 --profile backup <command>...

Or you can set environment variable to avoid repeating this:

    export AWS_PROFILE=backup
    aws s3 <command>...

For the rest of the notes, I'll assume the correct profile is set with the `AWS_PROFILE` environment variable.

### Creating S3 Bucket

Use [AWS S3](https://s3.console.aws.amazon.com/s3/home) to create a bucket for the backup:

* let's call it `backup.example.lck.com` for the purposes of these notes. The ARN would be `arn:aws:s3:::backup.example.com`
* start with default permissions, with no public access

Creating a bucket can also be done from the command line with high-level command:

    aws s3 mb s3://backup.example.lck.com

Or alternatively:

    aws s3api create-bucket --acl private --bucket backup.example.lck.com --region ap-southeast-1 --create-bucket-configuration LocationConstraint=ap-southeast-1

But note: this creates a bucket that allows objects to be public. We can tighten that up with public access block configuration:

    aws s3api put-public-access-block --bucket backup.example.lck.com --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

Later, I remove the bucket with, using the force parameter to allow deletion when not empty:

    aws s3 rb s3://backup.example.lck.com --force

### Making Something to Backup

The [create_backup_example_folder.sh](./create_backup_example_folder.sh) script creates something to backup:

    $ ./create_backup_example_folder.sh
    Creating backup_example_folder..
    .. adding backup_example_folder/test1.txt
    .. adding backup_example_folder/test2.txt
    .. adding backup_example_folder/test3.txt
    .. adding backup_example_folder/docs/test3.txt
    .. adding backup_example_folder/docs/test3.txt
    .. adding backup_example_folder/docs/test3.txt
    done.

### Performing a Basic folder Sync

The [aws s3 sync](https://docs.aws.amazon.com/cli/latest/userguide/using-s3-commands.html) is where all the magic happens.
It only copies differences from source to target.

On first request, it copies all files:

    $ aws s3 sync backup_example_folder s3://backup.example.lck.com/backup_example_folder
    upload: backup_example_folder/docs/doc1.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc1.txt
    upload: backup_example_folder/docs/doc2.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc2.txt
    upload: backup_example_folder/docs/doc3.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc3.txt
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt
    upload: backup_example_folder/test3.txt to s3://backup.example.lck.com/backup_example_folder/test3.txt
    upload: backup_example_folder/test1.txt to s3://backup.example.lck.com/backup_example_folder/test1.txt

If deletions, modifications or additions are made to local files.. for example:

    rm backup_example_folder/test3.txt
    echo "modification" >> backup_example_folder/test2.txt
    echo "new file" > backup_example_folder/test4.txt

Then a repeated sync will only send the differences:

    $ aws s3 sync backup_example_folder s3://backup.example.lck.com/backup_example_folder
    upload: backup_example_folder/test4.txt to s3://backup.example.lck.com/backup_example_folder/test4.txt
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt

Note that deletions were **not** included in the sync. This is the default behaviour - files are never deleted on the target.
In this case, it still contains the original files plus all additions and modifications:

    $ aws s3 ls s3://backup.example.lck.com --recursive
    2018-12-08 11:59:47         36 backup_example_folder/docs/doc1.txt
    2018-12-08 11:59:48         36 backup_example_folder/docs/doc2.txt
    2018-12-08 11:59:48         36 backup_example_folder/docs/doc3.txt
    2018-12-08 11:59:48         37 backup_example_folder/test1.txt
    2018-12-08 12:04:10         50 backup_example_folder/test2.txt
    2018-12-08 11:59:48         37 backup_example_folder/test3.txt
    2018-12-08 12:04:10          9 backup_example_folder/test4.txt

### Mirror Sync

Adding the `--delete` parameter to the sync command will fully mirror the file system (including deletions).

Making some more local modifications:

    echo "another modification" >> backup_example_folder/test2.txt
    echo "another new file" > backup_example_folder/test5.txt

Now a sync with `--delete` also sends the deletions...

    $ aws s3 sync backup_example_folder s3://backup.example.lck.com/backup_example_folder --delete
    delete: s3://backup.example.lck.com/backup_example_folder/test3.txt
    upload: backup_example_folder/test5.txt to s3://backup.example.lck.com/backup_example_folder/test5.txt
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt

Confirming:

    $ aws s3 ls s3://backup.example.lck.com --recursive
    2018-12-08 11:59:47         36 backup_example_folder/docs/doc1.txt
    2018-12-08 11:59:48         36 backup_example_folder/docs/doc2.txt
    2018-12-08 11:59:48         36 backup_example_folder/docs/doc3.txt
    2018-12-08 11:59:48         37 backup_example_folder/test1.txt
    2018-12-08 12:06:26         71 backup_example_folder/test2.txt
    2018-12-08 12:04:10          9 backup_example_folder/test4.txt
    2018-12-08 12:06:26         17 backup_example_folder/test5.txt

### Switching Targets: Sync to Local

The S3 sync command works in both directions. If a bucket needs to be synchronised to a local folder,
simply flip the source and destination parameters. For example:

    $ aws s3 sync s3://backup.example.lck.com/backup_example_folder backup_example_folder_clone
    download: s3://backup.example.lck.com/backup_example_folder/docs/doc3.txt to backup_example_folder_clone/docs/doc3.txt
    download: s3://backup.example.lck.com/backup_example_folder/test4.txt to backup_example_folder_clone/test4.txt
    download: s3://backup.example.lck.com/backup_example_folder/test2.txt to backup_example_folder_clone/test2.txt
    download: s3://backup.example.lck.com/backup_example_folder/test1.txt to backup_example_folder_clone/test1.txt
    download: s3://backup.example.lck.com/backup_example_folder/test5.txt to backup_example_folder_clone/test5.txt
    download: s3://backup.example.lck.com/backup_example_folder/docs/doc1.txt to backup_example_folder_clone/docs/doc1.txt

It is also possible to sync between S3 destinations. In this case, the data stays within Amazon (it is not transferred vai the local system)

    $ aws s3 sync s3://backup.example.lck.com/backup_example_folder s3://backup.example.lck.com/backup_example_folder_remote_replica
    copy: s3://backup.example.lck.com/backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder_remote_replica/test2.txt
    copy: s3://backup.example.lck.com/backup_example_folder/test5.txt to s3://backup.example.lck.com/backup_example_folder_remote_replica/test5.txt
    copy: s3://backup.example.lck.com/backup_example_folder/test4.txt to s3://backup.example.lck.com/backup_example_folder_remote_replica/test4.txt
    copy: s3://backup.example.lck.com/backup_example_folder/test1.txt to s3://backup.example.lck.com/backup_example_folder_remote_replica/test1.txt
    copy: s3://backup.example.lck.com/backup_example_folder/docs/doc3.txt to s3://backup.example.lck.com/backup_example_folder_remote_replica/docs/doc3.txt
    copy: s3://backup.example.lck.com/backup_example_folder/docs/doc1.txt to s3://backup.example.lck.com/backup_example_folder_remote_replica/docs/doc1.txt

### Storage Class

AWS S3 supports a range of storage classes, that affect performance, cost and retention.
These can be managed in the AWS console, but the sync command also accepts a `--storage-class` parameter. For example:

    aws s3 sync backup_example_folder s3://backup.example.lck.com/backup_example_folder --storage-class REDUCED_REDUNDANCY

| Storage Class       | Designed for                                                      | Availability Zones | Min storage duration | Retrieval fees? | Other Terms? |
|---------------------|-------------------------------------------------------------------|--------------------|----------------------|-----------------|--------------|
| STANDARD            | Frequently accessed data                                          | ≥ 3                | -                    | -               | -            |
| INTELLIGENT_TIERING | Long-lived data with changing or unknown access patterns          | ≥ 3                | -                    | -               | Yes          |
| STANDARD_IA         | Long-lived, infrequently accessed data                            | ≥ 3                | 30 days              | Yes             | Yes          |
| ONE-ZONE_IA         | Long-lived, infrequently accessed, non-critical data              | ≥ 1                | 30 days              | Yes             | Yes          |
| GLACIER             | Data archiving with retrieval times ranging from minutes to hours | ≥ 3                | 90 days              | Yes             | -            |
| REDUCED_REDUNDANCY  | Frequently accessed, non-critical data                            | ≥ 3                | -                    | -               | -            |

NB: other terms such as minimum billable object size, monitoring and automation fees may apply - see
[AWS Storage Classes](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html) documentation

## A Scripted Example

The [sync_example.sh](./sync_example.sh) puts a sequence of procedures together to demonstrate these steps.

    $ ./sync_example.sh

    This script demonstrates some s3 sync procedures.

    THIS IS DESTRUCTIVE:

    * it recreates the AWS S3 bucket: backup.example.lck.com
    * it recreates the local folder: backup_example_folder
    * it recreates the local folder: backup_example_folder_clone

    For S3 commands it will use the AWS_PROFILE=backup

    About to proceed .. Are you sure? (y/n) y
    Running..
    Looks like s3://backup.example.lck.com already exists, so removing it...
    delete: s3://backup.example.lck.com/backup_example_folder/docs/doc1.txt
    delete: s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc3 with spaces.txt
    delete: s3://backup.example.lck.com/backup_example_folder/docs/doc3.txt
    delete: s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc2 with spaces.txt
    delete: s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc1 with spaces.txt
    delete: s3://backup.example.lck.com/backup_example_folder/test5.txt
    delete: s3://backup.example.lck.com/backup_example_folder/test4.txt
    delete: s3://backup.example.lck.com/backup_example_folder/test2.txt
    delete: s3://backup.example.lck.com/backup_example_folder/test1.txt
    remove_bucket: backup.example.lck.com
    ## Creating s3://backup.example.lck.com
    make_bucket: backup.example.lck.com
    ## Applying s3://backup.example.lck.com restrictions
    Removing existing backup_example_folder..
    Creating backup_example_folder..
    .. adding backup_example_folder/test1.txt
    .. adding backup_example_folder/test2.txt
    .. adding backup_example_folder/test3.txt
    .. adding backup_example_folder/docs/doc1.txt
    .. adding backup_example_folder/docs/doc2.txt
    .. adding backup_example_folder/docs/doc3.txt
    .. adding backup_example_folder/folder with spaces/doc1 with spaces.txt
    .. adding backup_example_folder/folder with spaces/doc2 with spaces.txt
    .. adding backup_example_folder/folder with spaces/doc3 with spaces.txt
    done.
    ## Performing initial sync..
    ## Sync backup_example_folder to s3://backup.example.lck.com ..
    upload: backup_example_folder/docs/doc2.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc2.txt
    upload: backup_example_folder/test1.txt to s3://backup.example.lck.com/backup_example_folder/test1.txt
    upload: backup_example_folder/docs/doc1.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc1.txt
    upload: backup_example_folder/folder with spaces/doc3 with spaces.txt to s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc3 with spaces.txt
    upload: backup_example_folder/test3.txt to s3://backup.example.lck.com/backup_example_folder/test3.txt
    upload: backup_example_folder/docs/doc3.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc3.txt
    upload: backup_example_folder/folder with spaces/doc1 with spaces.txt to s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc1 with spaces.txt
    upload: backup_example_folder/folder with spaces/doc2 with spaces.txt to s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc2 with spaces.txt
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt
    ## Listing s3://backup.example.lck.com..
    2019-07-21 22:26:26         36 backup_example_folder/docs/doc1.txt
    2019-07-21 22:26:25         36 backup_example_folder/docs/doc2.txt
    2019-07-21 22:26:26         36 backup_example_folder/docs/doc3.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc1 with spaces.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc2 with spaces.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc3 with spaces.txt
    2019-07-21 22:26:26         37 backup_example_folder/test1.txt
    2019-07-21 22:26:26         37 backup_example_folder/test2.txt
    2019-07-21 22:26:26         37 backup_example_folder/test3.txt
    ## Re-sync: should have no changes to exchange..
    ## Sync backup_example_folder to s3://backup.example.lck.com ..
    ## Listing s3://backup.example.lck.com..
    2019-07-21 22:26:26         36 backup_example_folder/docs/doc1.txt
    2019-07-21 22:26:25         36 backup_example_folder/docs/doc2.txt
    2019-07-21 22:26:26         36 backup_example_folder/docs/doc3.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc1 with spaces.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc2 with spaces.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc3 with spaces.txt
    2019-07-21 22:26:26         37 backup_example_folder/test1.txt
    2019-07-21 22:26:26         37 backup_example_folder/test2.txt
    2019-07-21 22:26:26         37 backup_example_folder/test3.txt
    ## Making some local file modifications..
    ## Sync backup_example_folder to s3://backup.example.lck.com ..
    upload: backup_example_folder/test4.txt to s3://backup.example.lck.com/backup_example_folder/test4.txt
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt
    ## Listing s3://backup.example.lck.com.. contains additions and modifications, but not deletions (yet)
    2019-07-21 22:26:26         36 backup_example_folder/docs/doc1.txt
    2019-07-21 22:26:25         36 backup_example_folder/docs/doc2.txt
    2019-07-21 22:26:26         36 backup_example_folder/docs/doc3.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc1 with spaces.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc2 with spaces.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc3 with spaces.txt
    2019-07-21 22:26:26         37 backup_example_folder/test1.txt
    2019-07-21 22:26:29         50 backup_example_folder/test2.txt
    2019-07-21 22:26:26         37 backup_example_folder/test3.txt
    2019-07-21 22:26:29          9 backup_example_folder/test4.txt
    ## Making some more local file modifications..
    ## Sync backup_example_folder to s3://backup.example.lck.com --delete..
    delete: s3://backup.example.lck.com/backup_example_folder/docs/doc2.txt
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt
    delete: s3://backup.example.lck.com/backup_example_folder/test3.txt
    upload: backup_example_folder/test5.txt to s3://backup.example.lck.com/backup_example_folder/test5.txt
    ## Listing s3://backup.example.lck.com.. now contains additions, modifications and deletions
    2019-07-21 22:26:26         36 backup_example_folder/docs/doc1.txt
    2019-07-21 22:26:26         36 backup_example_folder/docs/doc3.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc1 with spaces.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc2 with spaces.txt
    2019-07-21 22:26:26         36 backup_example_folder/folder with spaces/doc3 with spaces.txt
    2019-07-21 22:26:26         37 backup_example_folder/test1.txt
    2019-07-21 22:26:30         71 backup_example_folder/test2.txt
    2019-07-21 22:26:29          9 backup_example_folder/test4.txt
    2019-07-21 22:26:30         17 backup_example_folder/test5.txt
    ## Cloning S3 Bucket to local backup_example_folder_clone..
    Removing existing backup_example_folder_clone
    download: s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc2 with spaces.txt to backup_example_folder_clone/folder with spaces/doc2 with spaces.txt
    download: s3://backup.example.lck.com/backup_example_folder/docs/doc1.txt to backup_example_folder_clone/docs/doc1.txt
    download: s3://backup.example.lck.com/backup_example_folder/test1.txt to backup_example_folder_clone/test1.txt
    download: s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc3 with spaces.txt to backup_example_folder_clone/folder with spaces/doc3 with spaces.txt
    download: s3://backup.example.lck.com/backup_example_folder/docs/doc3.txt to backup_example_folder_clone/docs/doc3.txt
    download: s3://backup.example.lck.com/backup_example_folder/test5.txt to backup_example_folder_clone/test5.txt
    download: s3://backup.example.lck.com/backup_example_folder/folder with spaces/doc1 with spaces.txt to backup_example_folder_clone/folder with spaces/doc1 with spaces.txt
    download: s3://backup.example.lck.com/backup_example_folder/test2.txt to backup_example_folder_clone/test2.txt
    download: s3://backup.example.lck.com/backup_example_folder/test4.txt to backup_example_folder_clone/test4.txt

### Using Wasabi

[Wasabi](https://wasabi.com) provides an AWS-compatible interface, so the same aws command line tools can be used with it.

It just requires a custom endpoint URL to be provided. There are currently three region-specific endpoints available:

* for Wasabi us-east, use s3.wasabisys.com
* for Wasabi us-west, use s3.us-west-1.wasabisys.com
* for Wasabi eu-central, use s3.eu-central-1.wasabisys.com

To use Wasabi with aws-cli, configure a profile with keys from Wasabi:

    aws configure --profile wasabi

Then run the usual commands, but with the appropriate `--endpoint-url` parameter, e.g.:

    aws s3 --profile wasabi --endpoint-url=https://s3.wasabisys.com sync backup_example_folder s3://backup.example.lck.com/backup_example_folder

Using [awscli-plugin-endpoint](https://github.com/wbingli/awscli-plugin-endpoint) can allow the endpoint-url configuration to be set in the profile,
so it doesn't need to be added to each command. I haven't actually used the awscli-plugin-endpoint yet.

The scripted sync example can also be used with wasabi by providing the correct profile and endpoint details:

    $ AWS_PROFILE=wasabi AWS_ENDPOINT_URL=https://s3.wasabisys.com ./sync_example.sh

    This script demonstrates some s3 sync procedures.

    THIS IS DESTRUCTIVE:

    * it recreates the AWS S3 bucket: backup.example.lck.com
    * it recreates the local folder: backup_example_folder
    * it recreates the local folder: backup_example_folder_clone

    For S3 commands it will use the AWS_PROFILE=wasabi --endpoint-url=https://s3.wasabisys.com

    About to proceed .. Are you sure? (y/n)

#### Wasabi Gotchas

I'm now happily using a sync to Wasabi as an additional offsite backup, but I did encounter a few issues along the way:

1. I initially had some routing issues to us-west that have since been solved by wasabi. My fallback at the time was to use the default us-east location.

2. One very large collection of files would always want to re-send the same subset of files (i.e. redundant sync).
This problem didn't occur with AWS S3 on the same file set.
Wasabi support eventually helped find a solution: add a `--page-size 10000` to the sync command.
It may be there is a development change coming to Wasabi that will make the default behaviour a bit more in line with AWS S3.

## Credits and References

* [Jungle Disk](https://en.wikipedia.org/wiki/Jungle_Disk)
* [Wasabi Hot Backup](https://wasabi.com)
* [AWS S3](https://s3.console.aws.amazon.com/s3/home)
* [AWS CLI tools](https://docs.aws.amazon.com/cli/latest/reference/)
* [AWS CLI S3 Online Help](https://docs.aws.amazon.com/cli/latest/userguide/using-s3-commands.html)
* [AWS Storage Classes](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html)
