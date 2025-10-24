# #377 Split by Widths

Using ruby to split strings into chunks of specified widths; cassidoo's interview question of the week (2025-10-20).

## Notes

The [interview question of the week (2025-10-20)](https://buttondown.com/cassidoo/archive/it-takes-courage-to-grow-up-and-become-who-you/)
should play to ruby's strength and flexibility in array and string processing:

> Given a string str and an array of positive integers widths, write a function that splits the string into lines, each with the exact number of characters as specified by the corresponding width. Return an array of the substrings. Use the last width for any remaining characters if the array is shorter than needed.
>
> Example:
>
> ```ts
> const str = "Supercalifragilisticexpialidocious";
> const widths = [5, 9, 4];
>
> > splitByWidths(str, widths);
> > ['Super', 'califragi', 'list', 'icex', 'pial', 'idoc', 'ious']
> ```

### Thinking about the Problem

The widths array could be just right for the given string, or it could have a surfeit or excess of elements.

Similarly, the string may no match the widths exactly. We basically need to keep processing until all characters are consumed.

### A First Go

The key line is to pluck the next width but keep the last if we run out of elements: `width = widths.shift || width`

```ruby
def split_by_widths(input, widths)
  result = []
  index = 0
  while index < input.length do
    width = widths.shift || width
    result << input[index, width]
    index += width
  end
  result
end
```

Running some examples:

```sh
$ ./example.rb "Supercalifragilisticexpialidocious" "5, 9, 4"
["Super", "califragi", "list", "icex", "pial", "idoc", "ious"]
$ ./example.rb "Supercalifragilisticexpialidocious" "5, 9, 6"
["Super", "califragi", "listic", "expial", "idocio", "us"]
$ ./example.rb "abcdefg" "1"
["a", "b", "c", "d", "e", "f", "g"]
$ ./example.rb "abcdefghij" "3, 2, 4, 6, 6"
["abc", "de", "fghi", "j"]
```

### Tests

I've setup some validation in [test_example.rb](./test_example.rb):

```sh
$ ./test_example.rb
Run options: --seed 29972

# Running:

....

Finished in 0.000229s, 17467.2489 runs/s, 17467.2489 assertions/s.

4 runs, 4 assertions, 0 failures, 0 errors, 0 skips
```

### Example Code

Final code is in [example.rb](./example.rb):

```ruby
#!/usr/bin/env ruby

def split_by_widths(input, widths)
  result = []
  index = 0
  while index < input.length do
    width = widths.shift || width
    result << input[index, width]
    index += width
  end
  result
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} (string) (widths comma separated)"; exit) unless ARGV.length > 1
  input = ARGV[0]
  widths = ARGV[1].split(',').map(&:to_i)
  puts split_by_widths(input, widths).inspect
end
```

## Credits and References

* [cassidoo's interview question of the week (2025-10-20)](https://buttondown.com/cassidoo/archive/it-takes-courage-to-grow-up-and-become-who-you/)
