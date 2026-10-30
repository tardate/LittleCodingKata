# #xxx halloweenSwap

Using ruby to swap halloween costumes: cassidoo's interview question of the week (2026-10-25).

## Notes

The [interview question of the week (2026-mm-dd)](https://cassidoo.co/newsletter/2026-10-25/):

> Each person at a Halloween party has exactly one costume, but they’ve been shuffled: costumes[i] is the index of the person who owns the costume person i is wearing. Return the minimum number of swaps between any two people needed to give everyone their own costume.
>
> Example:
>
> ```ts
> > halloweenSwap([0, 1, 2, 3])
> > 0
>
> > halloweenSwap([1, 2, 0])
> > 2
>
> > halloweenSwap([4, 3, 2, 1, 0])
> > 2
>
> > halloweenSwap([2, 3, 4, 0, 1])
> > 4
> ```

### Thinking about the Problem

We should be able to just iterate the array and if a swap is required, make the swap.
By the end of the array, all members should have the correct costume.

This lends itself to a situation where we mutate the array itself.

### Initial Solution

Here's a first go, literally the iterating the array and swapping costumes as required:

```ruby
def halloweenSwap(costumes)
  swaps = 0
  (0...costumes.length).each do |i|
    next if costumes[i] == i

    # Find the person who owns the costume that person i is wearing
    j = costumes.index(i)

    # Swap the costumes
    costumes[i], costumes[j] = costumes[j], costumes[i]
    swaps += 1
  end
  swaps
end
```

And it seems to work well:

```sh
$ ./challenge.rb "0, 1, 2, 3"
Costumes: [0, 1, 2, 3]
Result:
0
$ ./challenge.rb "1, 2, 0"
Costumes: [1, 2, 0]
Result:
2
$ ./challenge.rb "4, 3, 2, 1, 0"
Costumes: [4, 3, 2, 1, 0]
Result:
2
$ ./challenge.rb "2, 3, 4, 0, 1"
Costumes: [2, 3, 4, 0, 1]
Result:
4
```

### Tests

I've setup some validation in [test_challenge.rb](./test_challenge.rb):

```sh
$ ./test_challenge.rb
Run options: --seed 1467

# Running:

....

Finished in 0.000239s, 16736.4017 runs/s, 16736.4017 assertions/s.

4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

### Final Code

Final code is in [challenge.rb](./challenge.rb):

```ruby
#!/usr/bin/env ruby

def halloweenSwap(costumes)
  swaps = 0
  (0...costumes.length).each do |i|
    next if costumes[i] == i

    # Find the person who owns the costume that person i is wearing
    j = costumes.index(i)

    # Swap the costumes
    costumes[i], costumes[j] = costumes[j], costumes[i]
    swaps += 1
  end
  swaps
end

if __FILE__ == $PROGRAM_NAME
  (warn "Usage: ruby #{$0} <costumes-array>"; exit) unless ARGV.length == 1
  costumes = ARGV[0].split(',').map(&:to_i)
  warn "Costumes: #{costumes.inspect}"
  warn 'Result:'
  puts halloweenSwap(costumes)
end
```

## Credits and References

* [cassidoo's interview question of the week (2026-10-25)](https://cassidoo.co/newsletter/2026-10-25/)
