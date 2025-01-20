# #192 Huey Task Priority

Using the huey task priority feature.

## Notes

Huey added support for [Task priority](https://huey.readthedocs.io/en/latest/guide.html#task-priority)
since >=2.1.0.

### Demo Setup

Setup pre-requisites..

```
$ python --version
Python 3.7.3
$ pip install -r requirements.txt
...
```

Huey requires redis - the demo is setup to expect redis to be available on localhost:6379.

### Demo Program

#### Client

The [demo/client.py](./demo/client.py) simply runs a batch of tasks


```
$ python client.py
enqueuing tasks...
... lo_priority_task 0
... hi_priority_task 0
... lo_priority_task 1
... hi_priority_task 1
... lo_priority_task 2
... hi_priority_task 2
... lo_priority_task 3
... hi_priority_task 3
... lo_priority_task 4
... hi_priority_task 4
... lo_priority_task 5
... hi_priority_task 5
... lo_priority_task 6
... hi_priority_task 6
... lo_priority_task 7
... hi_priority_task 7
... lo_priority_task 8
... hi_priority_task 8
... lo_priority_task 9
... hi_priority_task 9
collating task results...
all tasks complete. results:
lo_priority_task 0 completed at 1629903692.143894
hi_priority_task 0 completed at 1629903693.145322
hi_priority_task 1 completed at 1629903694.150147
hi_priority_task 2 completed at 1629903695.154731
hi_priority_task 3 completed at 1629903696.160894
hi_priority_task 4 completed at 1629903697.1665761
hi_priority_task 5 completed at 1629903698.167873
hi_priority_task 6 completed at 1629903699.1702242
hi_priority_task 7 completed at 1629903700.171425
hi_priority_task 8 completed at 1629903701.1741529
hi_priority_task 9 completed at 1629903702.1754398
lo_priority_task 1 completed at 1629903703.1772852
lo_priority_task 2 completed at 1629903704.1804092
lo_priority_task 3 completed at 1629903705.184512
lo_priority_task 4 completed at 1629903706.189753
lo_priority_task 5 completed at 1629903707.191603
lo_priority_task 6 completed at 1629903708.192822
lo_priority_task 7 completed at 1629903709.194748
lo_priority_task 8 completed at 1629903710.195903
lo_priority_task 9 completed at 1629903711.199563

```

#### Tasks

The [demo/tasks.py](./demo/tasks.py) module implements two asynchronous task:

* `lo_priority_task` - runs with lower priority
* `hi_priority_task` - runs with higher priority

To use task priority, [PriorityRedisHuey](https://huey.readthedocs.io/en/latest/api.html#PriorityRedisHuey)
is used instead of [RedisHuey](https://huey.readthedocs.io/en/latest/api.html#RedisHuey).

Then tasks can be defined with a priority (high priorty number runs before low priority number) e.g.

```
@huey.task(priority=10)
def lo_priority_task(serial):
    ...
```

Running a single worker by default, with period tasks enabled:

```
$ cd demo/
$ huey_consumer.py tasks.huey
[2021-08-25 23:01:27,602] INFO:huey.consumer:MainThread:Huey consumer started with 1 thread, PID 78042 at 2021-08-25 15:01:27.602097
[2021-08-25 23:01:27,602] INFO:huey.consumer:MainThread:Scheduler runs every 1 second(s).
[2021-08-25 23:01:27,602] INFO:huey.consumer:MainThread:Periodic tasks are enabled.
[2021-08-25 23:01:27,602] INFO:huey.consumer:MainThread:The following commands are available:
+ tasks.lo_priority_task
+ tasks.hi_priority_task
[2021-08-25 23:01:31,143] INFO:huey:Worker-1:Executing tasks.lo_priority_task: 3bf71e75-a2d8-4a9a-92ac-0b3d17d9819d p=10
lo_priority_task 0 completed at 1629903692.143894
[2021-08-25 23:01:32,143] INFO:huey:Worker-1:tasks.lo_priority_task: 3bf71e75-a2d8-4a9a-92ac-0b3d17d9819d p=10 executed in 1.000s
[2021-08-25 23:01:32,145] INFO:huey:Worker-1:Executing tasks.hi_priority_task: 48e31aef-01b6-4719-ab07-45c20e0fdb44 p=20
hi_priority_task 0 completed at 1629903693.145322
...
```

## Credits and References

* [huey](https://github.com/coleifer/huey) - github
* [huey](https://huey.readthedocs.io/en/latest/index.html) - readthedocs
* [huey - Task priority](https://huey.readthedocs.io/en/latest/guide.html#task-priority)
