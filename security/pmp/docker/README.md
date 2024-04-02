# #xxx Running PMP in Docker?

Is it possible to run PMP in a Docker container? As far as my tests show - no. Not currently at least.

## Notes

> TLDR: while it is possible to package PMP in docker for Linux, it has too many dependencies and expectations about running on a non-virtualized OS. It cannot startup successfully.

When I was running a [trial of PMP](../about/), we used the Linux distribution.

I would have preferred to run a trial under Docker.
I made an attempt at this - the details are below - but it was not successful.

Perhaps PMP will arrived in a containerized or at least container-compatible form at some point, but for now it appears this is not possible (without perhaps doing some serious modification to the installation and startup scripts included in PMP).

### First attempt - on macOS

I started with a docker image based on ubuntu:22.04.
Built and started it, then ran the PMP installation interactively
from a bash console in the container to record an installation script
[install_script.txt](./install_script.txt).

```sh
docker-compose build
docker-compose run --rm pmp bash
docker run --rm -it --entrypoint bash lck/pmp
./ManageEngine_PMP_64bit.bin -r install_script.txt
```

Then updated the [Dockerfile](./Dockerfile) to attempt to startup PMP.

Various attempts to kick it into action and figure it out from the bash command line in the container:

```sh
root@3a3d50d922ef:/app/PMP/bin# bash pmp.sh reinit
wrapper  | --> Wrapper Started as Console
wrapper  | Java Service Wrapper Professional Edition 64-bit 3.5.25
wrapper  |   Copyright (C) 1999-2014 Tanuki Software, Ltd. All Rights Reserved.
wrapper  |     http://wrapper.tanukisoftware.com
wrapper  |   Licensed to Zoho Corporation Pvt. Ltd. for Password Manager Pro
wrapper  |
wrapper  | The configured wrapper.java.command could not be found, attempting to launch anyway: ../jre/bin/java

wrapper  | Launching a JVM...
jvm 1    | WrapperManager: Initializing...
jvm 1    | Trying to start PostgresSQL server failed
jvm 1    | Problem while reinitializing the DB
wrapper  | <-- Wrapper Stopped

[14:57:10:035]|[04-02-2024]|[com.adventnet.persistence.PersistenceInitializer]|[INFO]|[19]: Reading ../conf/database_params.conf |
[14:57:10:035]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: /app/PMP/bin/../pgsql/bin/pg_isready isExists :: true|
[14:57:10:040]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: Command to be executed [/app/PMP/bin/../pgsql/bin/pg_isready, --host, 127.0.0.1, --port, 2345, -t, 120, --username, pmpuser] |
[14:57:10:068]|[04-02-2024]|[SYSOUT]|[INFO]|[25]: 127.0.0.1:2345 - no response|
[14:57:10:068]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: pg_isready returning status :: 2|
[14:57:10:070]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: isServerRunning :: false|

/app/PMP/bin/../pgsql/bin/pg_isready  --host  127.0.0.1 --port 2345  -t 120 --username  pmpuser
127.0.0.1:2345 - no response

[14:57:10:201]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: Checking for IPV6 support|
[14:57:10:201]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: Resolved address of host [localhost] is [localhost/127.0.0.1]|
[14:57:10:202]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: Going to start DB server using pg_ctl utility.|
[14:57:10:202]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[SEVERE]|[19]: Command :: [/app/PMP/pgsql/bin/pg_ctl, -w, -D, /app/PMP/pgsql/data, -o, "-p2345", start]|
[14:57:10:217]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: Command to be executed ::: [stat, -c, %U, /app/PMP/pgsql/data]|
[14:57:10:231]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: dataDirectoryOwnerName :::: postgres|
[14:57:10:232]|[04-02-2024]|[com.adventnet.db.adapter.postgres.DefaultPostgresDBInitializer]|[INFO]|[19]: Command to be executed [su, -, postgres, -c, /app/PMP/pgsql/bin/pg_ctl -w -D /app/PMP/pgsql/data -o "-p2345" start ] |
[14:57:10:260]|[04-02-2024]|[pglog]|[INFO]|[26]: su: warning: cannot change directory to /app/PMP/pgsql: Permission denied|
[14:57:10:292]|[04-02-2024]|[pglog]|[INFO]|[26]: -sh: 1: /app/PMP/pgsql/bin/pg_ctl: Permission denied|

/app/PMP/pgsql/bin/pg_ctl -w -D /app/PMP/pgsql/data -o "-p2345" start

-- set uid/gid

pmp@60c9c9852f2d:/app/PMP/bin$ sudo bash pmp.sh start
Use wrapper to start PMP server.
pmp@60c9c9852f2d:/app/PMP/bin$ sudo bash pmp.sh install
logname: no login name
../scripts/install-service.sh: line 55: systemctl: command not found
../scripts/install-service.sh: line 56: systemctl: command not found
Password Manager Pro Service installed successfully !



$ /app/PMP/bin/wrapper -c /app/PMP/conf/wrapper_lin.conf
wrapper  | --> Wrapper Started as Console
wrapper  | Java Service Wrapper Professional Edition 64-bit 3.5.25
wrapper  |   Copyright (C) 1999-2014 Tanuki Software, Ltd. All Rights Reserved.
wrapper  |     http://wrapper.tanukisoftware.com
wrapper  |   Licensed to Zoho Corporation Pvt. Ltd. for Password Manager Pro
wrapper  |


wrapper  | Launching a JVM...
jvm 1    | WrapperManager: Initializing...
jvm 1    | Starting Server from location: /app/PMP
jvm 1    | Loading Modules
jvm 1    |
jvm 1    |      ModulePreStartProcess :: Persistence::DBAUDIT[ STARTED ]
jvm 1    |      ModulePreStartProcess :: Persistence::ROProcess[ STARTED ]
jvm 1    | Persistence                                       [POPULATED]
jvm 1    |      ModulePostStartProcess:: Persistence::DBAUDIT[ STARTED ]
wrapper  | JVM received a signal UNKNOWN (6).
jvm 1    |      ModulePostStartProcess:: Persistence::ROProcess#
jvm 1    | # A fatal error has been detected by the Java Runtime Environment:
jvm 1    | #
jvm 1    | #  SIGBUS (0x7) at pc=0x00007ffffeb01b50, pid=225, tid=0x00007fffe08ff640
jvm 1    | #
jvm 1    | # JRE version: OpenJDK Runtime Environment (8.0_372-b07) (build 1.8.0_372-b07)
jvm 1    | # Java VM: OpenJDK 64-Bit Server VM (25.372-b07 mixed mode linux-amd64 compressed oops)
jvm 1    | # Problematic frame:
jvm 1    | # V  [libjvm.so+0xb01b50]  Unsafe_SetOrderedInt+0xb0
jvm 1    | #
jvm 1    | # Failed to write core dump. Core dumps have been disabled. To enable core dumping, try "ulimit -c unlimited" before starting Java again
jvm 1    | #
jvm 1    | # An error report file with more information is saved as:
jvm 1    | # /app/PMP/bin/hs_err_pid225.log
jvm 1    | #
jvm 1    | # If you would like to submit a bug report, please visit:
jvm 1    | #   https://github.com/adoptium/adoptium-support/issues
jvm 1    | #
wrapper  | JVM process is gone.
wrapper  | JVM exited unexpectedly.


wrapper  | Launching a JVM...
jvm 2    | WrapperManager: Initializing...
jvm 2    | Starting Server from location: /app/PMP
jvm 2    | This evaluation copy is valid for 29 days
jvm 2    | Modules already Populated
jvm 2    |
jvm 2    |      ModulePreStartProcess :: Persistence::DBAUDIT[ STARTED ]
jvm 2    |      ModulePreStartProcess :: Persistence::ROProcess[ STARTED ]
jvm 2    | Persistence                                       [ LOADED ]
jvm 2    |      ModulePostStartProcess:: Persistence::DBAUDIT[ STARTED ]
jvm 2    |      ModulePostStartProcess:: Persistence::ROProcess
jvm 2    |
jvm 2    | Stopping Module processors
jvm 2    |
jvm 2    | ModuleStopProcess:: Persistence::ROProcess     [ STOPPED ]
jvm 2    | ModuleStopProcess:: Persistence::DBAUDIT     [ STOPPED ]
jvm 2    | System halted
jvm 2    |
jvm 2    |
jvm 2    | Problem while Starting Server
wrapper  | <-- Wrapper Stopped
```

OK, among other things its having a fundamental issue with the Java Runtime.

### build on linux

Let's try on Linux (to remove the processor architecture issue from the picture).

```sh
$ sudo docker compose build
[+] Building 74.8s (12/12) FINISHED                                                                                                                                  docker:default
 => [pmp internal] load build definition from Dockerfile                                                                                                                       0.0s
 => => transferring dockerfile: 825B                                                                                                                                           0.0s
 => [pmp internal] load metadata for docker.io/library/ubuntu:22.04                                                                                                            0.9s
 => [pmp internal] load .dockerignore                                                                                                                                          0.0s
 => => transferring context: 2B                                                                                                                                                0.0s
 => [pmp 1/7] FROM docker.io/library/ubuntu:22.04@sha256:77906da86b60585ce12215807090eb327e7386c8fafb5402369e421f44eff17e                                                      5.1s
 => => resolve docker.io/library/ubuntu:22.04@sha256:77906da86b60585ce12215807090eb327e7386c8fafb5402369e421f44eff17e                                                          0.0s
 => => sha256:77906da86b60585ce12215807090eb327e7386c8fafb5402369e421f44eff17e 1.13kB / 1.13kB                                                                                 0.0s
 => => sha256:aa772c98400ef833586d1d517d3e8de670f7e712bf581ce6053165081773259d 424B / 424B                                                                                     0.0s
 => => sha256:ca2b0f26964cf2e80ba3e084d5983dab293fdb87485dc6445f3f7bbfc89d7459 2.30kB / 2.30kB                                                                                 0.0s
 => => sha256:bccd10f490ab0f3fba61b193d1b80af91b17ca9bdca9768a16ed05ce16552fcb 29.54MB / 29.54MB                                                                               3.8s
 => => extracting sha256:bccd10f490ab0f3fba61b193d1b80af91b17ca9bdca9768a16ed05ce16552fcb                                                                                      1.2s
 => [pmp internal] load build context                                                                                                                                          0.0s
 => => transferring context: 674B                                                                                                                                              0.0s
 => [pmp 2/7] RUN apt update &&     apt install unzip &&     apt install -y sudo &&     addgroup --gid 1001 pmp &&     adduser --uid 1001 --gid 1001 --disabled-password --g  17.2s
 => [pmp 3/7] RUN mkdir /app &&     chown pmp:pmp /app                                                                                                                         0.2s
 => [pmp 4/7] WORKDIR /app                                                                                                                                                     0.0s
 => [pmp 5/7] COPY --chown=pmp:pmp ManageEngine_PMP_64bit.bin install_script.txt /app                                                                                          0.3s
 => [pmp 6/7] RUN chmod u+x ManageEngine_PMP_64bit.bin                                                                                                                         0.4s
 => [pmp 7/7] RUN ./ManageEngine_PMP_64bit.bin -i silent -f /app/install_script.txt                                                                                           48.6s
 => [pmp] exporting to image                                                                                                                                                   2.0s
 => => exporting layers                                                                                                                                                        2.0s
 => => writing image sha256:eaa99bc15a4cd129aed7dd0100552ff5e0038c38e85aa1f2f8cdb5b8a0288d0d                                                                                   0.0s
 => => naming to docker.io/lck/pmp                                                                                                                                             0.0s

docker-compose run --rm pmp bash
sudo docker run --rm -it --entrypoint bash lck/pmp

# startup attempt

        $ /app/PMP/bin/wrapper -c /app/PMP/conf/wrapper_lin.conf
        wrapper  | --> Wrapper Started as Console
        wrapper  | Java Service Wrapper Professional Edition 64-bit 3.5.25
        wrapper  |   Copyright (C) 1999-2014 Tanuki Software, Ltd. All Rights Reserved.
        wrapper  |     http://wrapper.tanukisoftware.com
        wrapper  |   Licensed to Zoho Corporation Pvt. Ltd. for Password Manager Pro
        wrapper  |


        wrapper  | Launching a JVM...
        jvm 1    | WrapperManager: Initializing...
        jvm 1    | Starting Server from location: /app/PMP
        jvm 1    | Loading Modules
        jvm 1    |
        jvm 1    |      ModulePreStartProcess :: Persistence::DBAUDIT[ STARTED ]
        jvm 1    |      ModulePreStartProcess :: Persistence::ROProcess[ STARTED ]
        jvm 1    | Persistence                                       [POPULATED]
        jvm 1    |      ModulePostStartProcess:: Persistence::DBAUDIT[ STARTED ]
        jvm 1    |      ModulePostStartProcess:: Persistence::ROProcess[ STARTED ]
        jvm 1    | Audit                                             [POPULATED]
        jvm 1    | Authentication                                    [POPULATED]
        jvm 1    | Authorization                                     [POPULATED]
        jvm 1    | CustomView                                        [POPULATED]
        jvm 1    | TaskEngine                                        [POPULATED]
        jvm 1    | Tomcat                                            [POPULATED]
        jvm 1    | ClientFramework                                   [POPULATED]
        jvm 1    | ClientComponents
        jvm 1    |                                   [POPULATED]
        jvm 1    | pki
        jvm 1    |                                                [POPULATED]
        jvm 1    | PassTrix
        jvm 1    |                                           [POPULATED]
        jvm 1    | PIM                                               [POPULATED]
        jvm 1    | adsf
        jvm 1    |                                               [POPULATED]
        jvm 1    | PushNotifier                                      [POPULATED]
        jvm 1    |
        jvm 1    | Creating Services
        jvm 1    | CacheService                                      [ CREATED ]
        jvm 1    | PatchUpdaterService                               [ CREATED ]
        jvm 1    | AuthenticationService                             [ CREATED ]
        jvm 1    | AuthorizationService                              [ CREATED ]
        jvm 1    | TaskEngineService                                 [ CREATED ]
        jvm 1    | WebService                                        [ CREATED ]
        jvm 1    | ClientFrameworkService                            [ CREATED ]
        jvm 1    | TableTemplateService                              [ CREATED ]
        jvm 1    | TemplateService                                   [ CREATED ]
        jvm 1    | KMPService                                        [ CREATED ]
        jvm 1    | PassTrixService                                   [ CREATED ]
        jvm 1    | GatewayService                                    [ CREATED ]
        jvm 1    | FOSService                                        [ CREATED ]
        jvm 1    | ADSFService                                       [ CREATED ]
        jvm 1    |
        jvm 1    | Starting Services
        jvm 1    | CacheService                                      [ STARTED ]
        jvm 1    | PatchUpdaterService                               [ STARTED ]
        jvm 1    | AuthenticationService                             [ STARTED ]
        jvm 1    | AuthorizationService                              [ STARTED ]
        jvm 1    | TaskEngineService                                 [ STARTED ]
        jvm 1    | WebService                                        [ STARTED ]
        jvm 1    | ClientFrameworkService                            [ STARTED ]
        jvm 1    | TableTemplateService                              [ STARTED ]
        jvm 1    | TemplateService                                   [ STARTED ]
        jvm 1    | KMPService                                        [ STARTED ]
        jvm 1    | PassTrixService                                   [ STARTED ]
        jvm 1    | GatewayService                                    [ STARTED ]
        jvm 1    | FOSService                                        [ STARTED ]
        jvm 1    | ADSFService                                       [ STARTED ]
        jvm 1    | Connect to : https://89f27948cace:7272/
        jvm 1    |
        jvm 1    | Server started in :: [37303 ms]
        jvm 1    |

but cannot repeat?? always fails on PassTrixService

        $ /app/PMP/bin/wrapper -c /app/PMP/conf/wrapper_lin.conf
        wrapper  | --> Wrapper Started as Console
        wrapper  | Java Service Wrapper Professional Edition 64-bit 3.5.25
        wrapper  |   Copyright (C) 1999-2014 Tanuki Software, Ltd. All Rights Reserved.
        wrapper  |     http://wrapper.tanukisoftware.com
        wrapper  |   Licensed to Zoho Corporation Pvt. Ltd. for Password Manager Pro
        wrapper  |


        wrapper  | Launching a JVM...
        jvm 1    | WrapperManager: Initializing...
        jvm 1    | Starting Server from location: /app/PMP
        jvm 1    | Loading Modules
        jvm 1    |
        jvm 1    |      ModulePreStartProcess :: Persistence::DBAUDIT[ STARTED ]
        jvm 1    |      ModulePreStartProcess :: Persistence::ROProcess[ STARTED ]
        jvm 1    | Persistence                                       [POPULATED]
        jvm 1    |      ModulePostStartProcess:: Persistence::DBAUDIT[ STARTED ]
        jvm 1    |      ModulePostStartProcess:: Persistence::ROProcess[ STARTED ]
        jvm 1    | Audit                                             [POPULATED]
        jvm 1    | Authentication                                    [POPULATED]
        jvm 1    | Authorization                                     [POPULATED]
        jvm 1    | CustomView                                        [POPULATED]
        jvm 1    | TaskEngine                                        [POPULATED]
        jvm 1    | Tomcat                                            [POPULATED]
        jvm 1    | ClientFramework                                   [POPULATED]
        jvm 1    | ClientComponents
        jvm 1    |                                   [POPULATED]
        jvm 1    | pki
        jvm 1    |                                                [POPULATED]
        jvm 1    | PassTrix
        jvm 1    |                                           [POPULATED]
        jvm 1    | PIM                                               [POPULATED]
        jvm 1    | adsf
        jvm 1    |                                               [POPULATED]
        jvm 1    | PushNotifier                                      [POPULATED]
        jvm 1    |
        jvm 1    | Creating Services
        jvm 1    | CacheService                                      [ CREATED ]
        jvm 1    | PatchUpdaterService                               [ CREATED ]
        jvm 1    | AuthenticationService                             [ CREATED ]
        jvm 1    | AuthorizationService                              [ CREATED ]
        jvm 1    | TaskEngineService                                 [ CREATED ]
        jvm 1    | WebService                                        [ CREATED ]
        jvm 1    | ClientFrameworkService                            [ CREATED ]
        jvm 1    | TableTemplateService                              [ CREATED ]
        jvm 1    | TemplateService                                   [ CREATED ]
        jvm 1    | KMPService                                        [ CREATED ]
        jvm 1    | PassTrixService                                   [ CREATED ]
        jvm 1    | GatewayService                                    [ CREATED ]
        jvm 1    | FOSService                                        [ CREATED ]
        jvm 1    | ADSFService                                       [ CREATED ]
        jvm 1    |
        jvm 1    | Starting Services
        jvm 1    | CacheService                                      [ STARTED ]
        jvm 1    | PatchUpdaterService                               [ STARTED ]
        jvm 1    | AuthenticationService                             [ STARTED ]
        jvm 1    | AuthorizationService                              [ STARTED ]
        jvm 1    | TaskEngineService                                 [ STARTED ]
        jvm 1    | WebService                                        [ STARTED ]
        jvm 1    | ClientFrameworkService                            [ STARTED ]
        jvm 1    | TableTemplateService                              [ STARTED ]
        jvm 1    | TemplateService                                   [ STARTED ]
        jvm 1    | KMPService                                        [ STARTED ]
        jvm 1    | PassTrixService                                   [ FAILED ]
        jvm 1    |
        jvm 1    | Stopping Services
        jvm 1    | KMPService                                        [ STOPPED ]
        jvm 1    | TemplateService                                   [ STOPPED ]
        jvm 1    | TableTemplateService                              [ STOPPED ]
        jvm 1    | ClientFrameworkService                            [ STOPPED ]
        jvm 1    | WebService                                        [ STOPPED ]
        jvm 1    | TaskEngineService                                 [ STOPPED ]
        jvm 1    | AuthorizationService                              [ STOPPED ]
        jvm 1    | AuthenticationService                             [ STOPPED ]
        jvm 1    | PatchUpdaterService                               [ STOPPED ]
        jvm 1    | CacheService                                      [ STOPPED ]
        jvm 1    | Destroying Services
        jvm 1    | ADSFService                                       [DESTROYED]
        jvm 1    | FOSService                                        [DESTROYED]
        jvm 1    | GatewayService                                    [DESTROYED]
        jvm 1    | PassTrixService                                   [DESTROYED]
        jvm 1    | KMPService                                        [DESTROYED]
        jvm 1    | TemplateService                                   [DESTROYED]
        jvm 1    | TableTemplateService                              [DESTROYED]
        jvm 1    | ClientFrameworkService                            [DESTROYED]
        jvm 1    | WebService                                        [DESTROYED]
        jvm 1    | TaskEngineService                                 [DESTROYED]
        jvm 1    | AuthorizationService                              [DESTROYED]
        jvm 1    | AuthenticationService                             [DESTROYED]
        jvm 1    | PatchUpdaterService                               [DESTROYED]
        jvm 1    | CacheService                                      [DESTROYED]
        jvm 1    | Stopping Module processors
        jvm 1    |
        jvm 1    | ModuleStopProcess:: Persistence::ROProcess     [ STOPPED ]
        jvm 1    | ModuleStopProcess:: Persistence::DBAUDIT     [ STOPPED ]
        jvm 1    |
        jvm 1    |
        jvm 1    | Problem while Starting Server
        jvm 1    | System halted
        wrapper  | <-- Wrapper Stopped
```

So no go also.

Giving up at this point. Seems to go further I'd need to start delving into the PMP startup scripts and updating them to not assume host services.

## Credits and References

* [PMP Download](https://www.manageengine.com/products/passwordmanagerpro/download.html)
* [Installing Password Manager Pro - Linux](https://www.manageengine.com/products/passwordmanagerpro/help/installation.html#inst-lin)
* [Running a Docker Container with a Custom Non-Root User: Syncing Host and Container Permissions](https://dev.to/izackv/running-a-docker-container-with-a-custom-non-root-user-syncing-host-and-container-permissions-26mb)
