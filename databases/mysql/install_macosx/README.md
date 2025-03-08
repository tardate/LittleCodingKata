# #197 MySQL on macOS

Notes on installing and running MySQL client and/or server on macOS

## Notes

The following demonstrates the installation of MySQL on macOS:

* installing server with homebrew
* installing client only with homebrew

### Installing MySQL Server with brew

```sh
brew install mysql
mysql.server start
```

```sh
$ mysql.server status
 SUCCESS! MySQL running (708)
```

```sh
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

Installed file locations:

* `/usr/local/opt/mysql` - binaries, linked to `../Cellar/mysql/8.0.18_1`
* `/usr/local/var/mysql` - data

### Installing MySQL Client with brew

```sh
$ brew install mysql-client
...
==> mysql-client
mysql-client is keg-only, which means it was not symlinked into /opt/homebrew,
because it conflicts with mysql (which contains client libraries).

If you need to have mysql-client first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"' >> /Users/myhome/.bash_profile

For compilers to find mysql-client you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

For pkg-config to find mysql-client you may need to set:
  export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"
```

Add `/opt/homebrew/opt/mysql-client/bin` to the path as instructed, then the mysql command line utility is available for use:

```sh
$ which mysql
/opt/homebrew/opt/mysql-client/bin/mysql
$ mysql --version
mysql  Ver 9.0.1 for macos15.0 on arm64 (Homebrew)
```

### Native Authentication

When attempting a connection with native authentication you may get the error:

```sh
ERROR 2059 (HY000): Authentication plugin 'mysql_native_password' cannot be loaded: ...
```

This is because the native authentication plugin was removed from mysql 9.0.
You need to install mysql@8.4 or mysql-client@8.4 (or use a different auth method)
To install 8.4 client, do this instead:

```sh
$ brew uninstall mysql-client # if already installed
$ brew install mysql-client@8.4
...
==> mysql-client@8.4
mysql-client@8.4 is keg-only, which means it was not symlinked into /opt/homebrew,
because this is an alternate version of another formula.

If you need to have mysql-client@8.4 first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/mysql-client@8.4/bin:$PATH"' >> /Users/paulgallagher/.bash_profile

For compilers to find mysql-client@8.4 you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/mysql-client@8.4/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/mysql-client@8.4/include"

For pkg-config to find mysql-client@8.4 you may need to set:
  export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client@8.4/lib/pkgconfig"
```

Add `/opt/homebrew/opt/mysql-client@8.4/bin` to the path as instructed, then the mysql command line utility is available for use:

```sh
$ which mysql
/opt/homebrew/opt/mysql-client@8.4/bin/mysql
$ mysql --version
mysql  Ver 8.4.3 for macos15.0 on arm64 (Homebrew)
```

Test it with an RDS instance:

```sh
$ mysql -h my-db-1.abc7abcabcab.ap-southeast-1.rds.amazonaws.com -u admin -p
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 30
Server version: 8.0.39 Source distribution

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

## Credits and References

* [mysql](https://formulae.brew.sh/formula/mysql) Homebrew Formula
* [mysql-client](https://formulae.brew.sh/formula/mysql-client) Homebrew Formula
* [How do I install command line MySQL client on mac?](https://stackoverflow.com/questions/30990488/how-do-i-install-command-line-mysql-client-on-mac) - stackoverflow
