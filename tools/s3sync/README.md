# s3sync

Using Amazon S3 or Wasabi for offsite data backup and long term storage.

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

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

    $ aws s3 --profile backup <command>...

Or you can set environment variable to avoid repeating this:

    $ export AWS_PROFILE=backup
    $ aws s3 <command>...

For the rest of the notes, I'll assume the correct profile is set with the `AWS_PROFILE` enviornment variable.


### Creating S3 Bucket

Use [AWS S3](https://s3.console.aws.amazon.com/s3/home) to create a bucket for the backup:

* let's call it `backup.example.lck.com` for the purposes of these notes. The ARN would be `arn:aws:s3:::backup.example.com`
* start with default permissions, with no public access

Creating a bucket can also be done from the command line with high-level command:

    $ aws s3 mb s3://backup.example.lck.com

Or alternatively:

    aws s3api create-bucket --acl private --bucket backup.example.lck.com --region ap-southeast-1 --create-bucket-configuration LocationConstraint=ap-southeast-1

But note: this creates a bucket that allows objects to be public. We can tighten that up with public access block configuration:

    aws s3api put-public-access-block --bucket backup.example.lck.com --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true


Later, I remove the bucket with, using the force parameter to allow deletion when not empty:

    $ aws s3 rb s3://backup.example.lck.com --force


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

    $ rm backup_example_folder/test3.txt
    $ echo "modification" >> backup_example_folder/test2.txt
    $ echo "new file" > backup_example_folder/test4.txt

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

It is also possible to sync between S3 detinations. In this case, the data stays within Amazon (it is not transfered vai the local system)

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

    $ aws s3 sync backup_example_folder s3://backup.example.lck.com/backup_example_folder --storage-class REDUCED_REDUNDANCY


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
    remove_bucket: backup.example.lck.com
    ## Creating s3://backup.example.lck.com
    make_bucket: backup.example.lck.com
    Removing existing backup_example_folder..
    Creating backup_example_folder..
    .. adding backup_example_folder/test1.txt
    .. adding backup_example_folder/test2.txt
    .. adding backup_example_folder/test3.txt
    .. adding backup_example_folder/docs/doc1.txt
    .. adding backup_example_folder/docs/doc2.txt
    .. adding backup_example_folder/docs/doc3.txt
    done.
    ## Performing initial sync..
    ## Sync backup_example_folder to s3://backup.example.lck.com ..
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt
    upload: backup_example_folder/docs/doc3.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc3.txt
    upload: backup_example_folder/test1.txt to s3://backup.example.lck.com/backup_example_folder/test1.txt
    upload: backup_example_folder/docs/doc2.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc2.txt
    upload: backup_example_folder/test3.txt to s3://backup.example.lck.com/backup_example_folder/test3.txt
    upload: backup_example_folder/docs/doc1.txt to s3://backup.example.lck.com/backup_example_folder/docs/doc1.txt
    ## Listing s3://backup.example.lck.com..
    2018-12-08 14:03:26         36 backup_example_folder/docs/doc1.txt
    2018-12-08 14:03:26         36 backup_example_folder/docs/doc2.txt
    2018-12-08 14:03:26         36 backup_example_folder/docs/doc3.txt
    2018-12-08 14:03:26         37 backup_example_folder/test1.txt
    2018-12-08 14:03:26         37 backup_example_folder/test2.txt
    2018-12-08 14:03:26         37 backup_example_folder/test3.txt
    ## Making some local file modifications..
    ## Sync backup_example_folder to s3://backup.example.lck.com ..
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt
    upload: backup_example_folder/test4.txt to s3://backup.example.lck.com/backup_example_folder/test4.txt
    ## Listing s3://backup.example.lck.com.. contains additions and modifications, but not deletions (yet)
    2018-12-08 14:03:26         36 backup_example_folder/docs/doc1.txt
    2018-12-08 14:03:26         36 backup_example_folder/docs/doc2.txt
    2018-12-08 14:03:26         36 backup_example_folder/docs/doc3.txt
    2018-12-08 14:03:26         37 backup_example_folder/test1.txt
    2018-12-08 14:03:28         50 backup_example_folder/test2.txt
    2018-12-08 14:03:26         37 backup_example_folder/test3.txt
    2018-12-08 14:03:28          9 backup_example_folder/test4.txt
    ## Making some more local file modifications..
    ## Sync backup_example_folder to s3://backup.example.lck.com --delete..
    delete: s3://backup.example.lck.com/backup_example_folder/docs/doc2.txt
    delete: s3://backup.example.lck.com/backup_example_folder/test3.txt
    upload: backup_example_folder/test2.txt to s3://backup.example.lck.com/backup_example_folder/test2.txt
    upload: backup_example_folder/test5.txt to s3://backup.example.lck.com/backup_example_folder/test5.txt
    ## Listing s3://backup.example.lck.com.. now contains additions, modifications and deletions
    2018-12-08 14:03:26         36 backup_example_folder/docs/doc1.txt
    2018-12-08 14:03:26         36 backup_example_folder/docs/doc3.txt
    2018-12-08 14:03:26         37 backup_example_folder/test1.txt
    2018-12-08 14:03:30         71 backup_example_folder/test2.txt
    2018-12-08 14:03:28          9 backup_example_folder/test4.txt
    2018-12-08 14:03:30         17 backup_example_folder/test5.txt
    ## Cloning S3 Bucket to local backup_example_folder_clone..
    Removing existing backup_example_folder_clone
    download: s3://backup.example.lck.com/backup_example_folder/test5.txt to backup_example_folder_clone/test5.txt
    download: s3://backup.example.lck.com/backup_example_folder/test2.txt to backup_example_folder_clone/test2.txt
    download: s3://backup.example.lck.com/backup_example_folder/docs/doc1.txt to backup_example_folder_clone/docs/doc1.txt
    download: s3://backup.example.lck.com/backup_example_folder/docs/doc3.txt to backup_example_folder_clone/docs/doc3.txt
    download: s3://backup.example.lck.com/backup_example_folder/test4.txt to backup_example_folder_clone/test4.txt
    download: s3://backup.example.lck.com/backup_example_folder/test1.txt to backup_example_folder_clone/test1.txt

### Using Wasabi

[Wasabi](https://wasabi.com) provides an AWS-compatible interface, so the same aws command line tools can be used with it.

It just requires a custom endpoint URL to be provided. There are currently three region-specific endpoints available:

* for Wasabi us-east, use s3.wasabisys.com
* for Wasabi us-west, use s3.us-west-1.wasabisys.com
* for Wasabi eu-central, use s3.eu-central-1.wasabisys.com

To use Wasabi with aws-cli, configure a profile with keys from Wasabi:

    $ aws configure --profile wasabi

Then run the usual commands, but with the appropriate `--endpoint-url` parameter, e.g.:


    $ aws s3 --profile wasabi --endpoint-url=https://s3.wasabisys.com sync backup_example_folder s3://backup.example.lck.com/backup_example_folder

Using [awscli-plugin-endpoint](https://github.com/wbingli/awscli-plugin-endpoint) can allow the endpoint-url configuration to be set in the profile,
so it doesn't need to be added to each command. I haven't actually used the awscli-plugin-endpoint yet.

I initially had some routing issues to us-west that have since been solved by wasabi.
Here's what the routing currently looks like for me to us-east and us-west:


    $ sudo mtr -T -P 443 -w s3.wasabisys.com
    Start: 2019-06-23T14:52:07+0800
    HOST: labarrossa.local                                               Loss%   Snt   Last   Avg  Best  Wrst StDev
      1.|-- 192.168.0.1                                                     0.0%    10   24.5  22.5   4.4  82.5  22.6
      2.|-- 2.16.182.58.starhub.net.sg                                      0.0%    10   41.7  30.5   6.7  71.1  20.0
      3.|-- an-ts-br05.starhub.net.sg                                       0.0%    10    9.2  31.9   5.0 106.4  29.7
      4.|-- ???                                                            100.0    10    0.0   0.0   0.0   0.0   0.0
      5.|-- 203.117.36.53                                                   0.0%    10   17.2  19.0   6.0  45.5  12.0
      6.|-- ???                                                            100.0    10    0.0   0.0   0.0   0.0   0.0
      7.|-- v1144.core1.sin1.he.net                                         0.0%    10   13.2  37.1  10.8 131.6  38.4
      8.|-- 100ge16-2.core1.tyo1.he.net                                     0.0%    10   98.6 104.3  77.5 187.8  37.2
      9.|-- 100ge11-1.core1.sea1.he.net                                     0.0%    10  174.2 182.2 158.1 220.8  25.8
     10.|-- 100ge4-2.core1.msp1.he.net                                      0.0%    10  192.4 225.2 192.4 300.5  37.9
     11.|-- 100ge16-2.core1.ash1.he.net                                     0.0%    10  226.0 235.8 219.2 273.2  16.1
     12.|-- wasabi-technologies-inc.10gigabitethernet5-6.core1.ash1.he.net  0.0%    10  224.5 236.0 215.1 272.7  17.3
     13.|-- 38.27.106.19                                                    0.0%    10  231.1 245.3 220.1 321.2  31.6
    $ sudo mtr -T -P 443 -w s3.us-west-1.wasabisys.com
    Start: 2019-06-23T14:51:29+0800
    HOST: labarrossa.local                                  Loss%   Snt   Last   Avg  Best  Wrst StDev
      1.|-- 192.168.0.1                                        0.0%    10   21.6  18.1   5.2  48.6  11.6
      2.|-- 2.16.182.58.starhub.net.sg                         0.0%    10   19.3  26.6   9.5  74.2  24.1
      3.|-- an-ts-br05.starhub.net.sg                          0.0%    10   13.0  26.2  10.5  85.8  23.6
      4.|-- ???                                               100.0    10    0.0   0.0   0.0   0.0   0.0
      5.|-- 203.116.188.73                                     0.0%    10   11.4  30.1   8.6  87.9  31.2
      6.|-- ???                                               100.0    10    0.0   0.0   0.0   0.0   0.0
      7.|-- an-uts-int12.starhub.net.sg                        0.0%    10   60.6  32.3  13.3  68.9  20.2
      8.|-- unknown.telstraglobal.net                          0.0%    10   84.8  31.2   7.2  84.8  27.1
      9.|-- i-92.sgpl-core02.telstraglobal.net                 0.0%    10   27.5  29.0  13.5  60.0  16.4
     10.|-- i-10850.eqnx-core02.telstraglobal.net              0.0%    10  199.8 209.7 175.5 275.4  36.4
     11.|-- i-92.eqnx03.telstraglobal.net                      0.0%    10  186.4 197.2 177.7 260.8  24.4
     12.|-- be4637.ccr41.sjc03.atlas.cogentco.com              0.0%    10  184.6 192.8 177.0 209.7  12.0
     13.|-- be3669.ccr21.sfo01.atlas.cogentco.com              0.0%    10  198.4 207.5 179.8 250.6  27.9
     14.|-- be3694.ccr21.pdx01.atlas.cogentco.com              0.0%    10  232.1 212.4 195.6 238.6  15.4
     15.|-- be3659.agr12.pdx01.atlas.cogentco.com              0.0%    10  228.3 212.4 192.0 254.0  20.1
     16.|-- te0-0-1-3.nr11.b069367-0.pdx01.atlas.cogentco.com  0.0%    10  199.9 216.0 194.2 274.9  25.3
     17.|-- 38.104.105.82                                      0.0%    10  208.0 210.5 198.3 227.7  10.1
     18.|-- 76.191.80.11                                       0.0%    10  211.9 214.1 186.9 295.4  32.4


## Credits and References

* [Jungle Disk](https://en.wikipedia.org/wiki/Jungle_Disk)
* [Wasabi Hot Backup](https://wasabi.com)
* [AWS S3](https://s3.console.aws.amazon.com/s3/home)
* [AWS CLI tools](https://docs.aws.amazon.com/cli/latest/reference/)
* [AWS CLI S3 Online Help](https://docs.aws.amazon.com/cli/latest/userguide/using-s3-commands.html)
* [AWS Storage Classes](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html)
