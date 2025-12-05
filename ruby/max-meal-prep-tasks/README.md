# #391 maxMealPrepTasks

Using ruby to solve the meal preparation problem; cassidoo's interview question of the week (2025-11-24).
We're trying to find the maximum number of tasks we can handle serially .. sounds like a production planning problem to me!

## Notes

The [interview question of the week (2025-11-24)](https://buttondown.com/cassidoo/archive/a-dream-is-just-a-dream-a-goal-is-a-dream-with-a/)
is another interesting case of production scheduling:

> Given an array of meal prep tasks for Thanksgiving, where each task is represented as [taskName, startTime, endTime], return the maximum number of non-overlapping tasks you can complete, along with the names of the chosen tasks in the order they were selected. Task times are inclusive of start but exclusive of end.
>
> Example:
>
> ```ts
> const tasks = [
>   ["Make Gravy", 10, 11],
>   ["Mash Potatoes", 11, 12],
>   ["Bake Rolls", 11, 13],
>   ["Prep Salad", 12, 13]
> ];
>
> maxMealPrepTasks(tasks)
> > {
>     count: 3,
>     chosen: ["Make Gravy", "Mash Potatoes", "Prep Salad"]
>   }
> ```

### Thinking About the Problem

We want to perform the maximum number of non-overlapping tasks possible, so we intuitively prefer:

* short tasks over long tasks
* earliest available task over later ones

This sounds just like the Shortest Processing Time (SPT) scheduling algorithm:

* That is, when faced with more than one possible task, perform the one with the shortest processing time first.
* This will minimise mean flow time and mean lateness.
* Generally a good rule of thumb when in doubt

Let's go with that!

### Initial Solution

Here's the approach:

* first sort the items by start and end time (so we have earliest, shortest tasks first)
* iterate the list:
    * check if we can perform the task (based on start time)
    * if we can: add the task to our completed list
    * else ignore it

In code:

```ruby
def minAssemblyTime
  sorted_input = input.sort_by { |item| [item[1], item[2]] }

  result = { count: 0, chosen: [] }
  current_start = 0
  sorted_input.each do |item|
    name, start_at, end_at = item
    next unless start_at >= current_start

    current_start = end_at
    result[:count] += 1
    result[:chosen] << name
  end

  result
end
```

Running with the example data provided, setup in [data1.json](./data1.json). Looks good!:

```sh
$ ./examples.rb data1.json
Input array: [["Make Gravy", 10, 11], ["Mash Potatoes", 11, 12], ["Bake Rolls", 11, 13], ["Prep Salad", 12, 13]]
Adding ["Make Gravy", 10, 11]: start_at: 10, end_at: 11
Adding ["Mash Potatoes", 11, 12]: start_at: 11, end_at: 12
Adding ["Prep Salad", 12, 13]: start_at: 12, end_at: 13
Result: {:count=>3, :chosen=>["Make Gravy", "Mash Potatoes", "Prep Salad"]}
```

Lets create some more contention in the data, see [data2.json](./data2.json):

* "Mash Potatoes" in contention with "Make Gravy". "Make Gravy" should be selected as it is shorter.
* "Bake Rolls" in contention with "Prep Salad". "Prep Salad" should be selected as it is shorter.

```json
[
  ["Mash Potatoes", 10, 12],
  ["Make Gravy", 10, 11],
  ["Bake Rolls", 14, 16],
  ["Prep Salad", 14, 15]
]
```

An we get the expected result:

```sh
$ ./examples.rb data2.json
Input array: [["Mash Potatoes", 10, 12], ["Make Gravy", 10, 11], ["Bake Rolls", 14, 16], ["Prep Salad", 14, 15]]
Adding ["Make Gravy", 10, 11]: start_at: 10, end_at: 11
Adding ["Prep Salad", 14, 15]: start_at: 14, end_at: 15
Result: {:count=>2, :chosen=>["Make Gravy", "Prep Salad"]}
```

### Tests

I've setup some validation in [test_examples.rb](./test_examples.rb):

```sh
$ ./test_examples.rb
Run options: --seed 24417

# Running:

..

Finished in 0.000213s, 9389.6714 runs/s, 9389.6714 assertions/s.

2 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```

### Example Code

Final code is in [examples.rb](./examples.rb):

```ruby
#!/usr/bin/env ruby
require 'json'

class MealPlanner
  attr_reader :input
  attr_reader :logging

  def initialize(input, logging = false)
    @input = input
    @logging = logging
  end

  def log(message)
    puts message if logging
  end

  def minAssemblyTime
    sorted_input = input.sort_by { |item| [item[1], item[2]] }

    result = { count: 0, chosen: [] }
    current_start = 0
    sorted_input.each do |item|
      name, start_at, end_at = item
      next unless start_at >= current_start

      log "Adding #{item}: start_at: #{start_at}, end_at: #{end_at}"
      current_start = end_at
      result[:count] += 1
      result[:chosen] << name
    end

    result
  end
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} (json-file)"; exit) unless ARGV.length > 0
  json_file_name = ARGV[0]
  begin
    input = JSON.parse(File.read(json_file_name))
  rescue
    puts "Error: Invalid JSON file - #{json_file_name}"
    exit
  end
  calculator = MealPlanner.new(input, true)
  puts "Input array: #{calculator.input.inspect}"
  puts "Result: #{calculator.minAssemblyTime}"
end
```

## Credits and References

* [cassidoo's interview question of the week (2025-11-24)](https://buttondown.com/cassidoo/archive/a-dream-is-just-a-dream-a-goal-is-a-dream-with-a/)
* [RIOT: The Scheduling Problem](https://riot.ieor.berkeley.edu/Applications/Scheduling/algorithms.html)
* [Optimal job scheduling](https://en.wikipedia.org/wiki/Optimal_job_scheduling)
* [Single-machine scheduling](https://en.wikipedia.org/wiki/Single-machine_scheduling)
