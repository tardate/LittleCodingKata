# #xxx Fireworks Grand finale

Using ruby to find the best fireworks grand finale; cassidoo's interview question of the week (2025-07-06).
This time I turned off the AI and enjoyed thinking about the deceptively simple algorithmic challenge from first principles.

## Notes

The [interview question of the week (2025-07-06)](https://buttondown.com/cassidoo/archive/a-genius-is-the-one-most-like-himself-thelonious/):

> Given an array of fireworks representing a series going off, write a function to find the "grand finale" of the show!
> A grand finale is defined as the longest sub-array where the average size is at least 5,
> the minimum velocity is 3, and the difference between the min and max height is no more than 10.
> Return the starting index of the grand finale.
>
> Example:
>
> const fireworks = [
> {height: 10, size: 6, velocity: 4},
> {height: 13, size: 3, velocity: 2},
> {height: 17, size: 6, velocity: 3},
> {height: 21, size: 8, velocity: 4},
> {height: 19, size: 5, velocity: 3},
> {height: 18, size: 4, velocity: 4}
> ];
>
> grandFinaleStart(fireworks)
> 2

### Initial Analysis and Solution

An eligible "grand finale" sub-array must meet the following criteria:

* `average(size) >= 5`
* `minimum(velocity) == 3`
* `maximum(height) - minimum(height) <= 10`

If this was a real problem, my "requirements analyst alarm" would be ringing, especially for the "minimum velocity is 3" requirement.
It seems unusual for that to be the one requirement expressed as an exact match, while the others are expressed as upper or lower limits.
I would want to ask for clarification; should it be, for example: "minimum velocity is *at least* 3"?

For my purposes here, I will start by taking the requirement at face value, and perhaps code a variant later. So `minimum(velocity) == 3` it is!

One may initially think that a limited scan would be sufficient: just iterate over elements until the criteria are not met.
However the calculation is complicated by the fact we have one criteria using an aggregate function (`average(size) >= 5`).
This raises the possibility that a shorter "invalid" sub-array can become part of a longer "valid" sub-array as more elements are added that skew the average size upwards.
For example:

| Element                              | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
|--------------------------------------|-----|-----|-----|-----|-----|-----|-----|
| `{height: 1, size: 5, velocity: 3},` | √   | √   | √   | √   | √   | √   | √   |
| `{height: 1, size: 1, velocity: 3},` |     | √   | √   | √   | √   | √   | √   |
| `{height: 1, size: 1, velocity: 3},` |     |     | √   | √   | √   | √   | √   |
| `{height: 1, size: 1, velocity: 3},` |     |     |     | √   | √   | √   | √   |
| `{height: 1, size: 2, velocity: 3},` |     |     |     |     | √   | √   | √   |
| `{height: 1, size: 50, velocity: 3},`|     |     |     |     |     | √   | √   |
| `{height: 1, size: 3, velocity: 3},` |     |     |     |     |     |     | √   |
| `average(size)`:                     | 5   | 3   | 2.3 | 2   | 2   | 10  | 9   |
| `minimum(velocity)`:                 | 3   | 3   | 3   | 3   | 3   | 3   | 3   |
| `maximum(height) - minimum(height)`: | 0   | 0   | 0   | 0   | 0   | 0   | 0   |
| valid?                               | Yes | No  | No  | No  | No  | Yes | Yes |

This shows how one outlier (size: 50) can rescue an otherwise failing sub-array, and even carry over for subsequent elements that are trying to bring the average back down.

The implication is that for every starting position, we really can't avoid checking all the way to the end of the array to see if a longer sub-array is possible.
At least that would be the naïve approach. A smarter approach may be to recognise that it is only necessary to keep checking when we know there are elements later in the array that could possibly pull the average back up. I will leave that optimisation for later (maybe).

See [examples.rb](./examples.rb) for the initial solution - it is an unoptimised evaluation of all possible spans.

Let's try it with the example provided. The data is in [data_eg1.json](./data_eg1.json):

    $ ./examples.rb data_eg1.json
    Using algorithm: initial_solution
    Input array: [{"height"=>10, "size"=>6, "velocity"=>4}, {"height"=>13, "size"=>3, "velocity"=>2}, {"height"=>17, "size"=>6, "velocity"=>3}, {"height"=>21, "size"=>8, "velocity"=>4}, {"height"=>19, "size"=>5, "velocity"=>3}, {"height"=>18, "size"=>4, "velocity"=>4}]
    Longest sub-array found: {:start=>2, :finish=>5, :length=>4}
    Result: 2

That's correct, now let's run it with the skewed average example above, with data in [data_eg2.json](./data_eg2.json). Also correct:

    $ ./examples.rb data_eg2.json
    Using algorithm: initial_solution
    Input array: [{"height"=>1, "size"=>5, "velocity"=>3}, {"height"=>1, "size"=>1, "velocity"=>3}, {"height"=>1, "size"=>1, "velocity"=>3}, {"height"=>1, "size"=>1, "velocity"=>3}, {"height"=>1, "size"=>2, "velocity"=>3}, {"height"=>1, "size"=>50, "velocity"=>3}, {"height"=>1, "size"=>3, "velocity"=>3}]
    Longest sub-array found: {:start=>0, :finish=>6, :length=>7}
    Result: 0

I've setup some extended validation in [test_examples.rb](./test_examples.rb):

    $ ./test_examples.rb
    Run options: --seed 54948

    # Running:

    .....

    Finished in 0.000281s, 17793.5943 runs/s, 17793.5943 assertions/s.

    5 runs, 5 assertions, 0 failures, 0 errors, 0 skips

### Optimizations?

As mentioned already, the initial algorithm is the unoptimised, naïve approach. It evaluates all possible sub-arrays and returns the longest.

Some possible optimisations that come to mind:

* transform the data into a form that is easier to process. A few options:
    * split the height, velocity, and size values into distinct number arrays
    * or put the data in a [Matrix](https://ruby-doc.org/stdlib-2.5.1/libdoc/matrix/rdoc/Matrix.html) object for column-wise processing
    * or consider [narray](https://rubygems.org/gems/narray) or [numo-narray](https://rubygems.org/gems/numo-narray) gems
    * or switch to python and numpy
* smarter evaluation of the results:
    * the code currently records all details of all matched sub-arrays (for inspection and information)
    * this is not necessary to get the expected answer
    * so evaluate each sub-array match immediately, and only record the result if it is better; throw away the rest
* short-circuit evaluation if it is known that a deficient average size cannot be recovered (the issue discussed above)
* and clarify the requirement: "minimum velocity is 3" or "minimum velocity is *at least* 3"

I haven't implemented any of these optimisations (yet).

### Example Code

Final code is in [examples.rb](./examples.rb):

    #!/usr/bin/env ruby
    require 'json'

    class GrandFinale
      attr_reader :input
      attr_reader :logging

      def initialize(input, logging = false)
        @input = input
        @logging = logging
      end

      def max_length
        @max_length ||= input.size
      end

      def log_result(result)
        puts "Longest sub-array found: #{result}" if logging
      end

      def valid?(start, finish)
        sizes = []
        heights = []
        velocities = []
        (start..finish).each do |i|
          sizes << input[i]['size']
          heights << input[i]['height']
          velocities << input[i]['velocity']
        end
        average_size = sizes.sum / sizes.size.to_f
        minimum_velocity = velocities.min
        maximum_height = heights.max
        minimum_height = heights.min

        average_size >= 5 &&
        minimum_velocity == 3 &&
        maximum_height - minimum_height <= 10
      end

      def initial_solution
        results = []
        max_length.times do |start|
          (start..max_length - 1).each do |finish|
            results << {start: start, finish: finish, length: finish - start + 1} if valid?(start, finish)
          end
        end
        result = results.max_by { |r| r[:length] }
        log_result(result)
        result&.dig(:start)
      end
    end

    if __FILE__==$PROGRAM_NAME
      (puts "Usage: ruby #{$0} (json-file) (algorithm)"; exit) unless ARGV.length > 0
      json_file_name = ARGV[0]
      algorithm = ARGV[1] || 'initial_solution'
      begin
        input = JSON.parse(File.read(json_file_name))
      rescue
        puts "Error: Invalid JSON file - #{json_file_name}"
        exit
      end
      puts "Using algorithm: #{algorithm}"
      calculator = GrandFinale.new(input, true)
      puts "Input array: #{calculator.input.inspect}"
      puts "Result: #{calculator.send(algorithm)}"
    end

## Credits and References

* [cassidoo's interview question of the week (2025-07-06)](https://buttondown.com/cassidoo/archive/a-genius-is-the-one-most-like-himself-thelonious/)
