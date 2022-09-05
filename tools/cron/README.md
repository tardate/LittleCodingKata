# cron

All about cron and OS-managed scheduled tasks

## Notes

[cron](https://en.wikipedia.org/wiki/Cron) is the classic and default job scheduler on Unix-like operating systems.

Schedules are defined a simple text `crontab` file. Users can have their own individual crontab files,
or jobs can be defined in the system level `/etc/crontab` or `/etc/cron.d`

crontab format:

    # ┌───────────── minute (0 - 59)
    # │ ┌───────────── hour (0 - 23)
    # │ │ ┌───────────── day of the month (1 - 31)
    # │ │ │ ┌───────────── month (1 - 12)
    # │ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday;
    # │ │ │ │ │                                   7 is also Sunday on some systems)
    # │ │ │ │ │
    # │ │ │ │ │
    # * * * * * <command to execute>


See [crontab.guru](https://crontab.guru/) for an easy way of creating the precise schedule format.

### ruby - Whenever

The [whenever](https://rubygems.org/gems/whenever) gem is perhaps the most common way of creating and deploying schedules
for ruby-based applications. It allows schedules to be defines with a friendly DSL.

## Credits and References

* [cron](https://en.wikipedia.org/wiki/Cron) - wikipedia
* [crontab.guru](https://crontab.guru/)
* [whenever](https://rubygems.org/gems/whenever)
