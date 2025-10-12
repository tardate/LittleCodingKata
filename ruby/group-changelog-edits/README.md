# #371 Grouping ChangeLog Edits

Using ruby to group data in 10-minute buckets; cassidoo's interview question of the week (2025-10-06).

## Notes

The [interview question of the week (2025-10-06)](https://buttondown.com/cassidoo/archive/the-invention-of-the-ship-was-also-the-invention/):

> You're building a tool that tracks component edits and groups them into a changelog. Given an array of edit actions, each with a timestamp and a component name, return an array of grouped changelog entries. Edits to the same component within a 10-minute window should be merged into one changelog entry, showing the component name and the range of timestamps affected.
>
> Example:
>
> ```js
> const edits = [
>   { timestamp: "2025-10-06T08:00:00Z", component: "Header" },
>   { timestamp: "2025-10-06T08:05:00Z", component: "Header" },
>   { timestamp: "2025-10-06T08:20:00Z", component: "Header" },
>   { timestamp: "2025-10-06T08:07:00Z", component: "Footer" },
>   { timestamp: "2025-10-06T08:15:00Z", component: "Footer" },
> ];
>
> > groupChangelogEdits(edits)
> > [
>     {
>         "component": "Footer",
>         "start": "2025-10-06T08:07:00Z",
>         "end": "2025-10-06T08:15:00Z"
>     },
>     {
>         "component": "Header",
>         "start": "2025-10-06T08:00:00Z",
>         "end": "2025-10-06T08:05:00Z"
>     },
>     {
>         "component": "Header",
>         "start": "2025-10-06T08:20:00Z",
>         "end": "2025-10-06T08:20:00Z"
>     }
> ]
> ```

## Thinking about the problem

I appears quite a simple problem, but grouping "edits to the same component within a 10-minute window" presents a number of possibilities,
and the requirements don't steer us in any particular direction. Another case where in the real world, there's a conversation required to get to the essential requirement. Here are some possibilities:

The most straight-forward and naïve approach: changes are grouped to the earliest change possible i.e. we just run through the changes chronologically.
This can however create some unrealistic groupings.
Consider the following example:

* changes at the following times: 8:05:00, 8:06:00, 8:14:00, 8:16:00, 8:16:10, 8:16:30
* The naïve approach would yield two groups: (8:05:00, 8:06:00, 8:14:00) and (8:16:00, 8:16:10, 8:16:30)
* However, if we are trying to group changes that happened "in the same burst of activity", the change at 8:14:00 is more closely associated with the second group, i.e. we should group as follows: (8:05:00, 8:06:00) and (8:14:00, 8:16:00, 8:16:10, 8:16:30)

In other words, a second approach would group changes to minimise the distance (time) between grouped elements.

However, both of these approaches produce groupings for the different components that are not going to be aligned.
In a real-world scenario, it may important to be able to align and compare changes across components within the same time buckets.
This would suggest an approach that would align the 10-minute buckets to a constant clock time.
While this may arise IRL, the first example grouping 08:07:00 to 08:15:00 demonstrates this is not the case in this question.

## Initial Approach

I'll keep it simple: the naïve approach that just starts trying to bucket for every successive change.

The core implementation looks pretty ugly:

* it first groups the data by component
* then we sort and process the components alphabetically (as it seems to have been done in the example)
* make sure the timestamps are sorted before grouping
* it groups by looking ahead to the next log entry. This avoids having to deal with a tail-end-charlie a the end of the loop

```ruby
  def initial_solution
    result = []
    logs_by_component = input.group_by { |entry| entry['component'] }
    logs_by_component.keys.sort.each do |key|
      log_times = logs_by_component[key].map { |entry| Time.parse(entry['timestamp']) }.sort
      current_log_start = nil
      log_times.size.times do |i|
        current_log_start ||= log_times[i]
        if log_times[i + 1].nil? || (log_times[i + 1] - current_log_start) > 10 * 60
          result << { 'component' => key, 'start' => current_log_start.utc.iso8601, 'end' => log_times[i].utc.iso8601 }
          current_log_start = nil
        end
      end
    end
    result
  end
```

Running with the example data set provided:

```sh
$ ./example.rb ./data_eg1.json
Using algorithm: initial_solution
Input array: [
  {
    "timestamp": "2025-10-06T08:00:00Z",
    "component": "Header"
  },
  {
    "timestamp": "2025-10-06T08:05:00Z",
    "component": "Header"
  },
  {
    "timestamp": "2025-10-06T08:20:00Z",
    "component": "Header"
  },
  {
    "timestamp": "2025-10-06T08:07:00Z",
    "component": "Footer"
  },
  {
    "timestamp": "2025-10-06T08:15:00Z",
    "component": "Footer"
  }
]
Result: [
  {
    "component": "Footer",
    "start": "2025-10-06T08:07:00Z",
    "end": "2025-10-06T08:15:00Z"
  },
  {
    "component": "Header",
    "start": "2025-10-06T08:00:00Z",
    "end": "2025-10-06T08:05:00Z"
  },
  {
    "component": "Header",
    "start": "2025-10-06T08:20:00Z",
    "end": "2025-10-06T08:20:00Z"
  }
]
```

And a second result using the example of clustered timings:

```sh
$ ./example.rb data_eg2.json
Using algorithm: initial_solution
Input array: [
  {
    "timestamp": "2025-10-06T08:05:00Z",
    "component": "Header"
  },
  {
    "timestamp": "2025-10-06T08:06:00Z",
    "component": "Header"
  },
  {
    "timestamp": "2025-10-06T08:14:00Z",
    "component": "Header"
  },
  {
    "timestamp": "2025-10-06T08:16:00Z",
    "component": "Header"
  },
  {
    "timestamp": "2025-10-06T08:16:10Z",
    "component": "Header"
  },
  {
    "timestamp": "2025-10-06T08:16:30Z",
    "component": "Header"
  }
]
Result: [
  {
    "component": "Header",
    "start": "2025-10-06T08:05:00Z",
    "end": "2025-10-06T08:14:00Z"
  },
  {
    "component": "Header",
    "start": "2025-10-06T08:16:00Z",
    "end": "2025-10-06T08:16:30Z"
  }
]
```

### Example Code

Final code is in [example.rb](./example.rb):

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'time'

class ChangeLogGrouper
  attr_reader :input
  attr_reader :logging

  def initialize(input, logging = false)
    @input = input
    @logging = logging
  end

  def initial_solution
    result = []
    logs_by_component = input.group_by { |entry| entry['component'] }
    logs_by_component.keys.sort.each do |key|
      log_times = logs_by_component[key].map { |entry| Time.parse(entry['timestamp']) }.sort
      current_log_start = nil
      log_times.size.times do |i|
        current_log_start ||= log_times[i]
        if log_times[i + 1].nil? || (log_times[i + 1] - current_log_start) > 10 * 60
          result << { 'component' => key, 'start' => current_log_start.utc.iso8601, 'end' => log_times[i].utc.iso8601 }
          current_log_start = nil
        end
      end
    end
    result
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
  calculator = ChangeLogGrouper.new(input, true)
  puts "Input array: #{JSON.pretty_generate(calculator.input)}"
  puts "Result: #{JSON.pretty_generate(calculator.send(algorithm))}"
end
```

With tests in [test_example.rb](./test_example.rb):

```sh
$ ./test_example.rb
Run options: --seed 38607

# Running:

..

Finished in 0.000544s, 3676.4706 runs/s, 3676.4706 assertions/s.

2 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [cassidoo's interview question of the week (2025-10-06)](https://buttondown.com/cassidoo/archive/the-invention-of-the-ship-was-also-the-invention/)
