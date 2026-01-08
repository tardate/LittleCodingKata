# #401 maxScoreWithOneReset

Using Erlang to maximise the sum of an array with 1 reset allowed; cassidoo's interview question of the week (2026-01-05).

## Notes

The [interview question of the week (2026-01-05)](https://buttondown.com/cassidoo/archive/hope-smiles-from-the-threshold-of-the-year-to/)
asks us to find the best reset strategy to maximise the sum:

> Given an integer array nums, sum each element in the array in order. You are allowed to use at most one reset during the run: when you reset, your current score becomes 0 and you continue with the next elements. Return the maximum score you can end with.
>
> Example:
>
> ```ts
> > maxScoreWithOneReset([2, -1, 2, -5, 2, 2]) // reset after -5
> > 4
>
> > maxScoreWithOneReset([4, -10, 3, 2, -1, 6]) // reset after -10
> > 10
>
> > maxScoreWithOneReset([-50, -2, -3]) // reset after -3
> > 0
> ```

## Thinking about the Problem

It's tempting to immediately grasp for some shortcuts, e.g.:

* reset after the biggest negative score - but this doesn't account for the accumulation of a string of negative scores
* reset after the longest streak of negative scores - no improvement, doesn't account for the accumulation of a string of negative scores
* reset on the last negative score - but this doesn't allow for a big drop followed by small ups and downs

Ultimately, what we probably need to do is reset at the point when the score is the most negative.

## A first approach

I've stretching myself by using Erlang for this one.

First I'll need a function to find the most negative position in the list, `find_min_pos`:

```erlang
find_min_pos(Nums) ->
    find_min_pos(Nums, 0, 0, 0, 0).

find_min_pos([], _Index, _RunningSum, _MinSum, MinPos) ->
    MinPos;

find_min_pos([H | T], Index, RunningSum, MinSum, MinPos) ->
    NewSum = RunningSum + H,
    case NewSum < MinSum of
        true  ->
            find_min_pos(T, Index + 1, NewSum, NewSum, Index + 1);
        false ->
            find_min_pos(T, Index + 1, NewSum, MinSum, MinPos)
    end.
```

And then a function to calculate the sum with reset, `sum_with_reset`:

```erlang
sum_with_reset(Nums, ResetPos) ->
    sum_with_reset(Nums, 0, 0, ResetPos).

sum_with_reset([], _Index, Acc, _ResetPos) ->
    Acc;

sum_with_reset([H | T], Index, Acc, ResetPos) ->
    NewAcc =
        case Index == ResetPos of
            true  -> H;
            false -> Acc + H
        end,
    sum_with_reset(T, Index + 1, NewAcc, ResetPos).
```

Tying that together with a main method `maxScoreWithOneReset`.
Importantly, it returns 0 if the calculated result is negative, as in this case it would always be wetter to reset at the end of the list.

```erlang
maxScoreWithOneReset(Nums) ->
    ResetPos = find_min_pos(Nums),
    FinalSum = sum_with_reset(Nums, ResetPos),
    max(FinalSum, 0).
```

Testing it out with the supplied examples:

```sh
$ erl
Erlang/OTP 28 [erts-16.1.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]

Eshell V16.1.2 (press Ctrl+G to abort, type help(). for help)
1> c(challenge).
{ok,challenge}
2> challenge:maxScoreWithOneReset([2, -1, 2, -5, 2, 2]).
4
3> challenge:maxScoreWithOneReset([4, -10, 3, 2, -1, 6]).
10
4> challenge:maxScoreWithOneReset([-50, -2, -3]).
0
5>
```

And some other more extreme test cases:

```sh
5> challenge:maxScoreWithOneReset([0, -50, 50, 2, -62, 60, -10, 300]). # reset after -62
350
```

### Example Code

Final code is in [challenge.erl](./challenge.erl):

```erlang
-module(challenge).
-export([maxScoreWithOneReset/1]).

maxScoreWithOneReset(Nums) ->
    ResetPos = find_min_pos(Nums),
    FinalSum = sum_with_reset(Nums, ResetPos),
    max(FinalSum, 0).

find_min_pos(Nums) ->
    find_min_pos(Nums, 0, 0, 0, 0).

find_min_pos([], _Index, _RunningSum, _MinSum, MinPos) ->
    MinPos;

find_min_pos([H | T], Index, RunningSum, MinSum, MinPos) ->
    NewSum = RunningSum + H,
    case NewSum < MinSum of
        true  ->
            find_min_pos(T, Index + 1, NewSum, NewSum, Index + 1);
        false ->
            find_min_pos(T, Index + 1, NewSum, MinSum, MinPos)
    end.

sum_with_reset(Nums, ResetPos) ->
    sum_with_reset(Nums, 0, 0, ResetPos).

sum_with_reset([], _Index, Acc, _ResetPos) ->
    Acc;

sum_with_reset([H | T], Index, Acc, ResetPos) ->
    NewAcc =
        case Index == ResetPos of
            true  -> H;
            false -> Acc + H
        end,
    sum_with_reset(T, Index + 1, NewAcc, ResetPos).
```

## Credits and References

* [cassidoo's interview question of the week (2026-01-05)](https://buttondown.com/cassidoo/archive/hope-smiles-from-the-threshold-of-the-year-to/)
* [LCK#397 About Erlang](../about/)
