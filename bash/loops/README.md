# #028 Bash Loops

All about Bash loops

## Notes

Iteration is a fundamental construct that is often needed for our scripting needs.
Bash provides a number of facilities for loops, including the
built-in commands `for`, `while` and `until`.

### Using `for`

The `for` command can be used to iterate a set or list of items.
See [for_in_list.sh](./for_in_list.sh) for an example or using a fixed list.
But anything that can product a list can also be used (like cat a file).

```bash
for fruit in "apples" "oranges" "pears"
do
  echo "loop with fruit==${fruit}"
done
```

Or can use a ranges.
See [for_in_range.sh](./for_in_range.sh) for an example...

```bash
for i in {1..9}
do
  echo "iteration ${i}"
done
```

### `while`

A `while` loop will execute until the [test](http://tldp.org/LDP/abs/html/tests.html) condition is not true.

```bash
n1=0
n2=5
while [ $n1 -le $n2 ]
do
  echo $n1
  n1=$(($n1+1))
done
```

See [while.sh](./while.sh) for an example...

```bash
$ ./while.sh 3
loop while -le 3
n1==0
n1==1
n1==2
n1==3
finished now n1==4
```

#### `while` with C-style increments

C-style increment (or decrement) syntax may be used i.e. `((n1++))`:

```bash
n1=0
n2=5
while [ $n1 -le $n2 ]
do
  echo $n1
  ((n1++))
done
```

See [while.sh](./while.sh) for an example...

```bash
$ ./while.sh 3 c-style-increment
loop while -le 3 with c-style increment
n1==0
n1==1
n1==2
n1==3
finished now n1==4
```

#### `while` with combined decrement and test

One can use a C-style test to increment/decrement and test in one statement:

```bash
n1=5
while ((n1--))
do
  echo "n1==${n1}"
done
```

See [while.sh](./while.sh) for an example...

```bash
$ ./while.sh 3 c-style-inline-decrement
loop from 3 to 0 with c-style inline decrement
n1==2
n1==1
n1==0
finished now n1==-1
```

### `until`

The `until` command is the complement of `while`: the loop will execute until the test condition is true.

```bash
n1=0
n2=5
until [ $n1 -ge $n2 ]
do
  echo $n1
  n1=$(($n1+1))
done
```

See [until.sh](./until.sh) for an example...

```bash
$ ./until.sh 3
loop with n1==0
loop with n1==1
loop with n1==2
finished now n1==3
```

### Infinite Loops

Just require a condition that always passes into the loop.

e.g. `true` with a `while` loop:

```bash
while true
do
  echo "Press [CTRL+C] to stop.."
  sleep 1
done
```

or with `for`:

```bash
for (( ; ; ))
do
  echo "Press [CTRL+C] to stop.."
  sleep 1
done
```

### One-liners

Simple loops can usually be collapsed to one-liners that can be used on the command line.
For example:

```bash
$ for i in {1..3}; do echo "iteration ${i}"; done
iteration 1
iteration 2
iteration 3
```

Or an infinite loop..

```bash
$ echo "infinite loop on a single line [ hit CTRL+C to stop]" ;  for (( ; ; )) ; do date ; sleep 1 ; done
infinite loop on a single line [ hit CTRL+C to stop]
Mon Oct  9 22:33:26 SGT 2017
Mon Oct  9 22:33:27 SGT 2017
Mon Oct  9 22:33:28 SGT 2017
```

## Credits and References

* [Advanced Bash-Scripting Guide: Chapter 7. Tests](http://tldp.org/LDP/abs/html/tests.html)
* [Advanced Bash-Scripting Guide: Chapter 11. Loops and Branches](http://tldp.org/LDP/abs/html/loops.html)
* [HowTo: Iterate Bash For Loop Variable Range Under Unix / Linux](https://www.cyberciti.biz/faq/unix-linux-iterate-over-a-variable-range-of-numbers-in-bash/)
* [Bash Infinite Loop Examples](https://www.cyberciti.biz/faq/bash-infinite-loop/)
