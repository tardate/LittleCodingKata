# #261 Minimal Django

The most bare-bones single file Django app

## Notes

How basic can you make a Django app?

### Install Dependencies

Using Python 3.7.3 to create and setup a virtual environment with the
requirepements as specified in [requirements.txt](./requirements.txt):

    $ python -V
    Python 3.7.3
    $ python -m venv venv
    $ source venv/bin/activate
    $ pip install --upgrade pip
    $ pip install -r requirements.txt

### Hello Echo Server

Everything is in [hello.py](./hello.py):

* minimal Django settings
* defines an `index` responder
* defines urlpatterns
* defines wsgi application
* if invoked as main script, defers to Django command line handler

Limitations and what is not included:

* there is no database - this will cause problems if trying to use standard Django tests

#### Running with Django Development Server

Use `runserver` option:

    $ python hello.py runserver
    Watching for file changes with StatReloader
    Performing system checks...

    System check identified no issues (0 silenced).
    May 16, 2023 - 22:48:26
    Django version 3.2.18, using settings None
    Starting development server at http://127.0.0.1:8000/
    Quit the server with CONTROL-C.
    [16/May/2023 22:48:31] "GET / HTTP/1.1" 200 12

Calling with curl:

    $ curl http://localhost:8000
    Hello World

#### Running with gunicorn

Alternatively, startup with gunicorn:

    $ gunicorn hello --log-file=-
    [2023-05-16 22:51:46 +0800] [35027] [INFO] Starting gunicorn 20.1.0
    [2023-05-16 22:51:46 +0800] [35027] [INFO] Listening at: http://127.0.0.1:8000 (35027)
    [2023-05-16 22:51:46 +0800] [35027] [INFO] Using worker: sync
    [2023-05-16 22:51:46 +0800] [35030] [INFO] Booting worker with pid: 35030

Calling with curl:

    $ curl http://localhost:8000
    Hello World

## Credits and References

* [Lightweight Django](https://learning.oreilly.com/library/view/lightweight-django/9781491946275/)
* [Django](https://www.djangoproject.com/)
* [gunicorn](https://gunicorn.org/)
