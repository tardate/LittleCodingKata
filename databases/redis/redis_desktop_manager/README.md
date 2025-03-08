# #196 Redis Desktop Manager

Building and running the Redis Desktop Manager applicaiton on macOS

## Notes

### Building from source macOS

Following the [instructions online](http://docs.redisdesktop.com/en/latest/install/#mac-os-x)..

Pre-requisites:

* Xcode and Homebrew - already installed
* `brew install openssl cmake python3`
* Install Qt 5.9. Add Qt Creator and under Qt 5.9.x add Qt Charts module (actual version installed: 5.9.9)


Get the source and prepare for build:

```
$ git clone --recursive https://github.com/uglide/RedisDesktopManager.git -b 2019 rdm && cd ./rdm
$ cd ./src && cp ./resources/Info.plist.sample ./resources/Info.plist
```

Install Python requirements

```
# in rdm/src
pip3 install -t ../bin/osx/release -r py/requirements.txt
```

Open the project `rdm/src/rdm.pro` in Qt Creator and build.

![qt_build](./assets/qt_build.png?raw=true)

It will make a "Redis Desktop Manager" executable:

```
$ ls -al rdm/bin/osx/debug/Redis*
-rwxr-xr-x@ 1 paulgallagher  staff  8931480 Mar 22 09:03 rdm/bin/osx/debug/Redis Desktop Manager
```

Running the app - works just fine!

Using it to inspect keys:

![rdm_inspect](./assets/rdm_inspect.png?raw=true)

And inspecting server stats:

![rdm_server_stats](./assets/rdm_server_stats.png?raw=true)

## Credits and References

* [RedisDesktopManager](https://github.com/uglide/RedisDesktopManager) - github
* [Redis Desktop Manager (aka RDM)](https://redisdesktop.com/) - commercial, packaged release of the project
