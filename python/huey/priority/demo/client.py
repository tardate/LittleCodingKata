#! /usr/bin/env python
from tasks import lo_priority_task
from tasks import hi_priority_task
import huey.api


def run_batch():
    tasks = []
    print('enqueuing tasks...')
    for i in range(10):
        print(f'... lo_priority_task {i}')
        tasks.append(lo_priority_task(i))
        print(f'... hi_priority_task {i}')
        tasks.append(hi_priority_task(i))

    print('collating task results...')
    results = []
    while len(results) < len(tasks):
        for i, task in enumerate(tasks):
            if isinstance(task, huey.api.Result):
                result = task.get()
                if result:
                    tasks[i] = result
                    results.append(result)

    print('all tasks complete. results:')
    for result in results:
        print(result)

if __name__ == '__main__':
    run_batch()
