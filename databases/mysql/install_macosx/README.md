# Running MySQL on MacOSX

Notes on installing and running MySQL on MacOSX

## Notes

### Installing with brew

```
$ brew install mysql
mysql.server start
```

```
$ mysql.server status
 SUCCESS! MySQL running (708)
```

```
$ brew info mysql
mysql: stable 8.0.18 (bottled)
Open source relational database management system
https://dev.mysql.com/doc/refman/8.0/en/
Conflicts with:
  mariadb (because mysql, mariadb, and percona install the same binaries.)
  percona-server (because mysql, mariadb, and percona install the same binaries.)
/usr/local/Cellar/mysql/8.0.18_1 (287 files, 280.7MB) *
  Poured from bottle on 2020-01-09 at 12:23:59
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/mysql.rb
==> Dependencies
Build: cmake ✔
Required: openssl@1.1 ✔, protobuf@3.7 ✔
==> Requirements
Required: macOS >= 10.10 ✔
==> Caveats
We've installed your MySQL database without a root password. To secure it run:
    mysql_secure_installation

MySQL is configured to only allow connections from localhost by default

To connect run:
    mysql -uroot

To have launchd start mysql now and restart at login:
  brew services start mysql
Or, if you don't want/need a background service you can just run:
  mysql.server start
==> Analytics
install: 68,390 (30 days), 212,385 (90 days), 839,501 (365 days)
install-on-request: 64,928 (30 days), 201,710 (90 days), 785,465 (365 days)
build-error: 0 (30 days)
```

## Locations

* `/usr/local/opt/mysql` - binaries, linked to `../Cellar/mysql/8.0.18_1`
* `/usr/local/var/mysql` - data

## Credits and References

* [mysql](https://formulae.brew.sh/formula/mysql) Homebrew Formula
