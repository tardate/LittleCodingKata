from huey import RedisHuey
from huey import crontab

huey = RedisHuey('lck')


@huey.task()
def add_numbers(a, b):
    return a + b


@huey.periodic_task(crontab(minute='*/2'))
def every_other_minute():
    print('This task runs every 2 minutes.')
