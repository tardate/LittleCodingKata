# Running a Kiss FFT Example

Test drive the Kiss FFT C library with an example.


## Notes

[Kiss FFT](http://sourceforge.net/projects/kissfft/) is an interesting FFT implementation in C.
It promises ease-of-use over absolute performance.

To build a project with Kiss FFT, it just needs the core files compiled and linked.

I found a [kissfft-example](https://github.com/crazyleen/kissfft-example) which I'm building here (under MacOS).

It has the core Kiss FFT files included in the repo, and links with the real-optimised version.
The Kiss FFT files it uses are:

```
_kiss_fft_guts.h
kiss_fft.c
kiss_fft.h
kiss_fftr.c
kiss_fftr.h
```

The kissfft-example comes with sample data and some python utilities for plotting the results.
Data files:

| File               | Description                                        |
|--------------------|----------------------------------------------------|
| 01_Real_Part.txt   | labview-generated FFT (for comparison)             |
| 02_Imagin_Part.txt | labview-generated FFT imaginary component (unused) |
| dump-raw-3.txt     | Raw data set                                       |
| test-output.txt    | Output generated from the FFT                      |


## Setting up the Python Environment

I'm using virtualenv, and it needs some special considerations due to restrictions of the matplotlib library
using in the python code - see [Working with Matplotlib in Virtual environments](http://matplotlib.org/faq/virtualenv_faq.html).

I'm setting my virtual environment path to `PYTHONHOME`:

```
$ export PYTHONHOME=$(cd ../../venv; pwd)
```

Then activating the environment to install requirements:
```
$ source $PYTHONHOME/bin/activate
(venv)$ pip install -r requirements.txt
(venv)$ deactivate
$
```

The virtualenv is deactivated before running the examples ... they'll find the virtualenv from the `PYTHONHOME` environment variable

## Running the kissfft-example

There are justa few commands to clone the kissfft-example repo, compile and run the FFT, then fire up the `draw-curve.py` python
script to visualise the results. I've put them in a shell script:

```
$ ./download_and_run
```

And here's an example of the output:

![draw-curve.png](./assets/draw-curve.png?raw=true)

## Credits and References
* [Kiss FFT Web Site](http://sourceforge.net/projects/kissfft/) - master on sourceforge
* [Mirror on GitHub](https://github.com/itdaniher/kissfft)
* [kissfft-example](https://github.com/crazyleen/kissfft-example)
* [Working with Matplotlib in Virtual environments](http://matplotlib.org/faq/virtualenv_faq.html)
