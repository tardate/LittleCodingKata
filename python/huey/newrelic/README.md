# Monitoring Huey with NewRelic

Notes and examples os using NewRelic monitoring with Huey

## Notes

Huey is [not explicitly supported by NewRelic](https://docs.newrelic.com/docs/agents/python-agent/getting-started/compatibility-requirements-python-agent/). I discovered this while working on a Django application with huey for queing: all the Django
activity appeared in NewRelic, but all the backgorund processing was missing ("invisible").

To enable NewRelic monitoring for Huey, I've discovered there are 2 key problems to address:

* agent initialisation needs to be aware that huey may spin off workers and schedulers as separate processes
  * if not initialised correctly, worker processes may not be monitored
* function tracing needs to "play nice" with huey decorators
  * if not declared in the correct order, huey can prevent newrelic from recording the function


### Demo Setup

Setup pre-requisites..

```
$ python --version
Python 3.7.3
$ pip install -r requirements.txt
...
```

Huey requires redis - the demo is setup to expect redis to be available on localhost:6379.

NewRelic Configuration: The examples that follow require a NewRelic account and license key and a `newrelic.ini` configuration file
generated
[according to the documentation](https://docs.newrelic.com/docs/agents/python-agent/installation/standard-python-agent-install/).

```
newrelic-admin generate-config YOUR_LICENSE_KEY newrelic.ini
```

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


### Agent Initialisation

In the examples that follow, I'm running multiple huey workers using process model.

#### Using Wrapper Script

The `newrelic-admin`
[wrapper script](https://docs.newrelic.com/docs/agents/python-agent/installation/python-agent-advanced-integration/#wrapper-script) is used to spawn a process with an initialised NewRelic agent.
Seems to work fine!

The following example uses the standard `huey_consumer.py` script to load and run the jobs in the `tasks` module:

```
$ cd demo
$ NEW_RELIC_CONFIG_FILE=../newrelic.ini newrelic-admin run-program huey_consumer.py tasks.huey --workers 2 --worker-type process
[2021-08-25 19:23:24,538] INFO:huey.consumer:70978:Huey consumer started with 2 process, PID 70978 at 2021-08-25 11:23:24.538648
[2021-08-25 19:23:24,539] INFO:huey.consumer:70978:Scheduler runs every 1 second(s).
[2021-08-25 19:23:24,539] INFO:huey.consumer:70978:Periodic tasks are enabled.
[2021-08-25 19:23:24,539] INFO:huey.consumer:70978:The following commands are available:
+ tasks.add_numbers
+ tasks.every_other_minute
[2021-08-25 19:23:24,572] INFO:huey:70981:Executing tasks.add_numbers: 3daa9eec-b38f-4cf3-8d91-094c73bb6807
[2021-08-25 19:23:24,594] INFO:huey:70981:tasks.add_numbers: 3daa9eec-b38f-4cf3-8d91-094c73bb6807 executed in 0.021s
[2021-08-25 19:23:26,375] INFO:huey:70982:Executing tasks.add_numbers: e975049c-a536-4903-9a9c-07ad3033b8db
...
```

Here's the resulting trace visible in NewRelic APM:

![huey_consumer](./assets/huey_consumer.png?raw=true)


### Adding basic instrumentation

Soince huey functions and our custom tasks are not known to NewRelic, they need to be instrumented in order to collect data.

The
[background_task (Python agent API)](https://docs.newrelic.com/docs/agents/python-agent/python-agent-api/backgroundtask-python-agent-api/)
decorator can be used to instrument background tasks or other non-web transactions. This is typically used to instrument non-web activity like worker processes, job-based systems, and standalone scripts.

See [demo/tasks.py](./demo/tasks.py) module for the annotated tasks.

To instrument huey tasks, it is necessary to ensure that the newrelic decorator is defined inside the huey decorator.
e..g this works:

```
@huey.task()
@newrelic.agent.background_task()
def add_numbers(a, b):
    return a + b
```

But this doesn't (task runs, but without reporting to NewRelic):
```
@newrelic.agent.background_task()
@huey.task()
def add_numbers(a, b):
    return a + b
```

## Custom Consumer

The [demo/run_huey.py](./demo/run_huey.py) is an example of a custom consumer
that demonstrates how to support NewRelic without needing the the `newrelic-admin` wrapper script.
It is a replacement and simple
derivative of the standard `huey_consumer.py` script.

The key point to note is that NewRelic initialisation needs to be aware we're running multi-process huey,
else we can get errors like this:

> 2021-08-25 21:08:31,594 (74243/MainThread) newrelic.core.application WARNING - Attempt to reactivate application or record transactions in a process different to where the agent was already registered for application 'lck-huey-nr'. No data will be reported for this process with pid of 74243. Registration of the agent for this application occurred in process with pid 74239. If no data at all is being reported for your application, then please report this problem to New Relic support for further investigation.


The [demo/run_huey.py](./demo/run_huey.py) demonstrates how to take care of agent initialisation and shutdown
in the huey
[`on_startup`](https://huey.readthedocs.io/en/latest/api.html#Huey.on_startup)
and
[`on_shutdown`](https://huey.readthedocs.io/en/latest/api.html#Huey.on_shutdown)
hooks.


```
$ NEW_RELIC_CONFIG_FILE=../newrelic.ini python run_huey.py tasks.huey --workers 2 --worker-type process
[2021-08-25 21:17:25,207] INFO:huey.consumer:74521:Huey consumer started with 2 process, PID 74521 at 2021-08-25 13:17:25.206952
[2021-08-25 21:17:25,207] INFO:huey.consumer:74521:Scheduler runs every 1 second(s).
[2021-08-25 21:17:25,207] INFO:huey.consumer:74521:Periodic tasks are enabled.
[2021-08-25 21:17:25,207] INFO:huey.consumer:74521:The following commands are available:
+ tasks.add_numbers
+ tasks.every_other_minute
process 74523, thread 140736157094784 - startup hook
process 74524, thread 140736157094784 - startup hook
[2021-08-25 21:17:25,390] INFO:huey:74523:Executing tasks.add_numbers: e46c744b-7d0a-4b9a-8e4c-89fdf8fdd3ef
[2021-08-25 21:17:25,392] INFO:huey:74523:tasks.add_numbers: e46c744b-7d0a-4b9a-8e4c-89fdf8fdd3ef executed in 0.001s
[2021-08-25 21:17:26,555] INFO:huey:74523:Executing tasks.add_numbers: 8dff4eea-1f9c-4e0b-b673-d253d0d11b5e
[2021-08-25 21:18:24,166] INFO:huey:74524:Executing tasks.add_numbers: cd9c5052-e5a1-4a74-b57e-7c520c26cbf0
...
[2021-08-25 21:18:24,167] INFO:huey:74524:tasks.add_numbers: cd9c5052-e5a1-4a74-b57e-7c520c26cbf0 executed in 0.001s
[2021-08-25 21:18:25,205] INFO:huey.consumer.Scheduler:74522:Enqueueing periodic task tasks.every_other_minute: b04e4aeb-2395-4f5f-8509-b8704dc868d6.
[2021-08-25 21:18:25,207] INFO:huey:74523:Executing tasks.every_other_minute: b04e4aeb-2395-4f5f-8509-b8704dc868d6
This task runs every 2 minutes.
[2021-08-25 21:18:25,208] INFO:huey:74523:tasks.every_other_minute: b04e4aeb-2395-4f5f-8509-b8704dc868d6 executed in 0.001s

...
```
Here's the resulting trace visible in NewRelic APM:

![run_huey](./assets/run_huey.png?raw=true)


## Credits and References

* [huey](https://github.com/coleifer/huey) - github
* [newrelic python agent](https://docs.newrelic.com/docs/agents/python-agent/) - docs
* [newrelic python agent](https://github.com/newrelic/newrelic-python-agent) - github
