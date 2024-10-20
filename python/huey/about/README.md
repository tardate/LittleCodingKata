# #190 Huey

Huey is a lightweight queuing system for python.

## Notes

Huey is a lightweight queuing system for python. Key features:

* python 2.7+ and 3.4+
* clean and simple API
* redis, sqlite, or in-memory storage

Huey supports:

* multi-process, multi-thread or greenlet task execution models
* schedule tasks to execute at a given time, or after a given delay
* schedule recurring tasks, like a crontab
* automatically retry tasks that fail
* task prioritization
* task result storage
* task expiration
* task locking
* task pipelines and chains

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

The [demo/client.py](./demo/client.py) simply runs an infinite loop - calling the asynchronous `add_numbers`
task to add two random integers.

```
$ python client.py
916 + 488 = 1404
460 + 634 = 1094
159 + 3 = 162
28 + 343 = 371
```

#### Tasks

The [demo/tasks.py](./demo/tasks.py) module implements two asynchronous task:

* `add_numbers` - returns the addition of two integer parameters
* `every_other_minute` - periodic task that runs every two minutes

Running a single worker by default, with period tasks enabled:

```
$ cd demo/
$ huey_consumer.py tasks.huey
[2021-08-25 21:47:06,519] INFO:huey.consumer:MainThread:Huey consumer started with 1 thread, PID 75523 at 2021-08-25 13:47:06.519226
[2021-08-25 21:47:06,519] INFO:huey.consumer:MainThread:Scheduler runs every 1 second(s).
[2021-08-25 21:47:06,519] INFO:huey.consumer:MainThread:Periodic tasks are enabled.
[2021-08-25 21:47:06,519] INFO:huey.consumer:MainThread:The following commands are available:
+ tasks.add_numbers
+ tasks.every_other_minute
[2021-08-25 21:48:00,550] INFO:huey:Worker-1:Executing tasks.add_numbers: fcc8c249-2f3f-4d95-9dcd-e9266ad2aa37
[2021-08-25 21:48:00,550] INFO:huey:Worker-1:tasks.add_numbers: fcc8c249-2f3f-4d95-9dcd-e9266ad2aa37 executed in 0.000s
...
[2021-08-25 21:48:06,520] INFO:huey.consumer.Scheduler:Scheduler:Enqueueing periodic task tasks.every_other_minute: 41120519-6b78-47a3-b1a5-41e6ecf8d6f9.
[2021-08-25 21:48:06,522] INFO:huey:Worker-1:Executing tasks.every_other_minute: 41120519-6b78-47a3-b1a5-41e6ecf8d6f9
This task runs every 2 minutes.
[2021-08-25 21:48:06,522] INFO:huey:Worker-1:tasks.every_other_minute: 41120519-6b78-47a3-b1a5-41e6ecf8d6f9 executed in 0.000s
[2021-08-25 21:48:07,196] INFO:huey:Worker-1:Executing tasks.add_numbers: b7659466-1765-4648-9328-3f058d154fad
...
```


## Credits and References

* [huey](https://github.com/coleifer/huey) - github
* [huey](https://huey.readthedocs.io/en/latest/index.html) - readthedocs
