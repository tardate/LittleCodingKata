# #382 The uv Python Package and Project Manager

About uv, a new Python package and project manager written in rust. It replaces pip, pip-tools, pipx, poetry, pyenv, twine, virtualenv, and more.

## Notes

I've long been of the opinion that virtual environment support is essential for any serious programming ecosystem.
For Python, [pyenv](../pyenv/) has been great, but it does suffer from the fact that it is just one of many tools that
are needed to manage a given environment.

Enter [uv](https://docs.astral.sh/uv/), a relatively new tool, written in rust. It’s designed as a drop-in replacement for pip, venv, and virtualenv, with a strong focus on speed, simplicity, and reproducibility.

### Installation

There are a range of [supported installation mechanisms](https://docs.astral.sh/uv/getting-started/installation/).
As I'm using macOS, I just used brew:

```sh
$ brew install uv
...
$ uv --version
uv 0.9.5 (Homebrew 2025-10-21)
```

### Common Commands

| Command                | Purpose                                           |
| ---------------------- | ------------------------------------------------- |
| `uv pip install <pkg>` | Fast replacement for `pip install`                |
| `uv venv`              | Create a virtual environment                      |
| `uv run <cmd>`         | Run Python commands or scripts in the environment |
| `uv lock`              | Generate a lockfile for reproducible installs     |
| `uv sync`              | Sync environment from `uv.lock`                   |

### Managing Virtual Environment with uv

The most natural adoption of uv is to use it like a direct replacement of pyenv and pip.
For example, let's setup an environment to manage and run a script that has package dependencies.

```sh
$ cd venv_demo
$ uv venv
Using CPython 3.11.14 interpreter at: /opt/homebrew/opt/python@3.11/bin/python3.11
Creating virtual environment at: .venv
Activate with: source .venv/bin/activate
$ source .venv/bin/activate
$ source .venv/bin/activate
(venv_demo) $ python --version
Python 3.11.14
(venv_demo) $ which python
./.venv/bin/python
```

The script we are going to run - [example.py](./example.py) - requires the [rich](https://pypi.org/project/rich/) package.

```python
import time
from rich.progress import track

for i in track(range(20), description="For example:"):
    time.sleep(0.05)
```

Let's install `rich` in the virtual environment:

```sh
$ uv pip install rich
Resolved 4 packages in 187ms
Prepared 4 packages in 342ms
Installed 4 packages in 8ms
 + markdown-it-py==4.0.0
 + mdurl==0.1.2
 + pygments==2.19.2
 + rich==14.2.0
```

Alternatively, if we have a pip-style [venv_demo/requirements.txt](./venv_demo/requirements.txt) file,
we can use it to install dependencies as we would with pip:

```sh
$ uv pip install -r requirements.txt
Audited 1 package in 3ms
```

Now we can run the script:

```sh
(venv_demo) $ python ../example.py
For example: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 0:00:01
```

### Managing Python Installations

If Python is already installed on the system, uv will detect and use it without configuration.
However, uv can also install and manage Python versions.

I currently have 3.11.14 system Python. Let's add 3.15 as a uv-managed python installation:

```sh
$ uv python install 3.15
Installed Python 3.15.0a1 in 3.31s

+ cpython-3.15.0a1-macos-aarch64-none (python3.15)
warning: `$HOME/.local/bin` is not on your PATH. To use installed Python executables, run `export PATH="$HOME/.local/bin:$PATH"` or `uv python update-shell`.
```

### Running Scripts With Dependencies

A neat feature of uv is its ability to run
[scripts with dependencies](https://docs.astral.sh/uv/guides/scripts/)
intended for standalone execution.

Let's run the same example, and by declaring its dependencies, uv will install them as required:

```sh
$ uv run --with rich example.py
Installed 4 packages in 5ms
For example: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 0:00:01
```

Now instead of having to declare the dependencies each time we run the script, it is better to let the script declare the dependencies itself. This is supported by uv.

Let's take the example script and add a specific python requirement and include the package dependencies:

```sh
$ cp example.py example_with_dependencies.py
$ uv init --script example_with_dependencies.py --python 3.12
Initialized script at `example_with_dependencies.py`
$ uv add --script example_with_dependencies.py rich
Updated `example_with_dependencies.py`
```

Our script  [example_with_dependencies.py](./example_with_dependencies.py) now looks like this:

```python
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "rich",
# ]
# ///

import time
from rich.progress import track

for i in track(range(20), description="For example:"):
    time.sleep(0.05)

```

And we can now run it and allow uv to figure out dependencies itself.

```sh
$ uv run example_with_dependencies.py
Installed 4 packages in 5ms
For example: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 0:00:01
```

### Using tools

Many Python packages provide applications that can be used as tools. uv has specialized support for easily [invoking and installing tools](https://docs.astral.sh/uv/guides/tools/).

Use `uvx` to invoke the desired tool, and it will be installed if necessary.

```sh
$ uvx pycowsay hello from uv
Installed 1 package in 3ms

  -------------
< hello from uv >
  -------------
   \   ^__^
    \  (oo)\_______
       (__)\       )\/\
           ||----w |
           ||     ||
```

### Projects

In `rust` we have `cargo` for setting up and managing projects. The same facilities are brought to Python by `uv`.

Let's create a new project called `demo`:

```sh
$ uv init demo
Initialized project `demo` at `./demo`
$ cd demo
$ ls -a1
.
..
.python-version
main.py
pyproject.toml
README.md
```

It has created a few files in the project structure:

* `.python-version` specifies the Python version that uv should use when creating a virtual environment
* `main.py` - a default program entrypoint with a `main()` function
* `pyproject.toml` - project dependencies and settings
* `README.md` - a default starting point for a project README

Let's update the Python requirement to 3.15 that is now installed and managed by uv, and add the `rich` package dependency.
This will trigger the automatic creation of a virtual environment.

```sh
$ echo "3.15" > .python-version
$ uv add rich
Using CPython 3.15.0a1
Creating virtual environment at: .venv
Resolved 5 packages in 17ms
Installed 4 packages in 5ms
 + markdown-it-py==4.0.0
 + mdurl==0.1.2
 + pygments==2.19.2
 + rich==14.2.0
```

At this point I've updated [demo/main.py](./demo/main.py)
with the same time tracker as used in the previous example:

```python
import time
from rich.progress import track

def main():
    for i in track(range(20), description="For example:"):
        time.sleep(0.05)

if __name__ == "__main__":
    main()

```

We can now activate the virtual environment and run our script:

```sh
$ source .venv/bin/activate
(demo) $ python main.py
For example: ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 0:00:01
```

### And More

That's a quick tour of some of the main features of `uv`. It can do quite a bit more, such as versioning, building, and publishing projects.

## Credits and References

* <https://docs.astral.sh/uv/>
* <https://github.com/astral-sh/uv>
