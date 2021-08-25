import time
from huey import PriorityRedisHuey

huey = PriorityRedisHuey('lck-huey-priority')


@huey.task(priority=10)
def lo_priority_task(serial):
    time.sleep(1)
    message = f'lo_priority_task {serial} completed at {time.time()}'
    print(message)
    return message


@huey.task(priority=20)
def hi_priority_task(serial):
    time.sleep(1)
    message = f'hi_priority_task {serial} completed at {time.time()}'
    print(message)
    return message
