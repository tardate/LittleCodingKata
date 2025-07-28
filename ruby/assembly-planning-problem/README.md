# #xxx The Keyboard Assembly Problem

Using ruby to solve the keyboard assembly problem; cassidoo's interview question of the week (2025-07-21).
Reminds me of my under-grad days learning production scheduling (SPT, EDD etc).
Now I realise how much I've internalised these concepts as part of my working practices to "get things done".

## Notes

The [interview question of the week (2025-07-21)](https://buttondown.com/cassidoo/archive/7309/)
is an interesting case of production scheduling:

> You’re assembling a custom mechanical keyboard.
> Each required part has a delivery time in days and an assembly time in hours.
> You can only assemble a part after it arrives, and you can only work on one part at a time.
> Given an array of parts where each part is { name, arrivalDays, assemblyHours },
> return the minimum total hours needed to finish assembling all parts, starting from hour 0.
>
> Example:
>
>     minAssemblyTime([
>     { name: "keycaps", arrivalDays: 1, assemblyHours: 2 },
>     { name: "switches", arrivalDays: 2, assemblyHours: 3 },
>     { name: "stabilizers", arrivalDays: 0, assemblyHours: 1 },
>     { name: "PCB", arrivalDays: 1, assemblyHours: 4 },
>     { name: "case", arrivalDays: 3, assemblyHours: 2 }
>     ])
>
> => 74

### Analysing the Problem

This rings all sorts of bells from my undergrad days,
in particular the "Scheduling n Tasks on m Processors" class of sequencing and scheduling problems
that I remember from
[Integrated Production, Control Systems: Management, Analysis, and Design](https://www.goodreads.com/book/show/2193350.Integrated_Production_Control_Systems).

The main constraints we are dealing with here are:

* can only work on one part at a time (i.e. a single processor)
* each part/process has an earliest start time (arrivalDays)

There are no due dates or dependencies between parts for sequencing.

IIRC, the most common approaches:

* Shortest Processing Time (SPT)
    * That is, when faced with more than one possible task, perform the one with the shortest processing time first.
    * This will minimise mean flow time and mean lateness.
    * Generally a good rule of thumb when in doubt
* Longest Processing Time (LPT)
    * That is, when faced with more than one possible task, perform the one with the longest processing time first.
    * Generally not preferred for single processors
* Earliest Due Date (EDD)
    * That is, when faced with more than one possible task, perform the one with the earliest due date first.
    * Minimises maximum lateness
    * Most appropriate where there is a consequential penalty for being late

PS: looking back on my career, I'd never really acknowledged how much I seem to have internalised these concepts in my working practices.
Whenever the crunch was on and the team overloaded, it was so natural to prioritise accordingly: EDD if a deadline was looming, or SPT if we just had more work than hands.

### First Pass

The example data provided ([data_eg1.json](./data_eg1.json)) does not really present any particular challenges: we only have one conflict for access to the processor (on day 1), and the conflict does not result in any cascading conflicts.
Any approach will work, so let's go with the general rule of thumb: SPT.

    $ ./examples.rb data_eg1.json
    Using algorithm: spt
    Input array: [{"name"=>"keycaps", "arrivalDays"=>1, "assemblyHours"=>2}, {"name"=>"switches", "arrivalDays"=>2, "assemblyHours"=>3}, {"name"=>"stabilizers", "arrivalDays"=>0, "assemblyHours"=>1}, {"name"=>"PCB", "arrivalDays"=>1, "assemblyHours"=>4}, {"name"=>"case", "arrivalDays"=>3, "assemblyHours"=>2}]
    Processing stabilizers: Arrival Days: 0, Assembly Hours: 1, Total Time: 1
    Processing keycaps: Arrival Days: 1, Assembly Hours: 2, Total Time: 26
    Processing PCB: Arrival Days: 1, Assembly Hours: 4, Total Time: 30
    Processing switches: Arrival Days: 2, Assembly Hours: 3, Total Time: 51
    Processing case: Arrival Days: 3, Assembly Hours: 2, Total Time: 74
    Result: 74

The SPT algorithm is the most basic:

* sort the tests by increasing Arrival Days and increasing Assembly Hours
* process in order

### Cascading Contention

Let's add some cascading conflicts, as in [data_eg2.json](./data_eg2.json):

     minAssemblyTime([
      { name: "part-a1", arrivalDays: 0, assemblyHours: 30 },
      { name: "part-a2", arrivalDays: 0, assemblyHours: 60 },
      { name: "part-b1", arrivalDays: 1, assemblyHours: 2 },
      { name: "part-b2", arrivalDays: 1, assemblyHours: 6 },
     ])

If we sort and then process by SPT, we get:

    $ ./examples.rb data_eg2.json
    Using algorithm: spt
    Input array: [{"name"=>"part-a1", "arrivalDays"=>0, "assemblyHours"=>30}, {"name"=>"part-a2", "arrivalDays"=>0, "assemblyHours"=>60}, {"name"=>"part-b1", "arrivalDays"=>1, "assemblyHours"=>2}, {"name"=>"part-b2", "arrivalDays"=>1, "assemblyHours"=>6}]
    Processing part-a1: Arrival Days: 0, Assembly Hours: 30, Total Time: 30
    Processing part-a2: Arrival Days: 0, Assembly Hours: 60, Total Time: 90
    Processing part-b1: Arrival Days: 1, Assembly Hours: 2, Total Time: 92
    Processing part-b2: Arrival Days: 1, Assembly Hours: 6, Total Time: 98
    Result: 98

If we were to re-sort after each task, we still get an overall processing time of 98 hours:

    Processing part-a1: Arrival Days: 0, Assembly Hours: 30, Total Time: 30
    Processing part-b1: Arrival Days: 1, Assembly Hours: 2, Total Time: 32
    Processing part-b2: Arrival Days: 1, Assembly Hours: 6, Total Time: 38
    Processing part-a2: Arrival Days: 0, Assembly Hours: 60, Total Time: 98
    Result: 98

Basically this is showing that with a single processor, one can never do better than 100% utilisation,
and the only time that utilisation will drop below 100% is if there is no job to run.
And lacking a job to run is a problem that no algorithm can solve.

### Tests

I've setup some validation in [test_examples.rb](./test_examples.rb):

    $ ./test_examples.rb
    Run options: --seed 21869

    # Running:

    ..

    Finished in 0.000224s, 8928.5714 runs/s, 8928.5714 assertions/s.

    2 runs, 2 assertions, 0 failures, 0 errors, 0 skips

### Example Code

Final code is in [examples.rb](./examples.rb):

    #!/usr/bin/env ruby
    require 'json'

    class AssemblyPlanning
      attr_reader :input
      attr_reader :logging

      def initialize(input, logging = false)
        @input = input
        @logging = logging
      end

      def log(message)
        puts message if logging
      end

      def spt
        sorted_input = input.sort_by { |item| [item['arrivalDays'], item['assemblyHours']] }

        total_time = 0
        sorted_input.each do |item|
          arrival_days = item['arrivalDays']
          arrival_hours = arrival_days * 24
          assembly_hours = item['assemblyHours']

          wait_hours = arrival_hours > total_time ? arrival_hours - total_time : 0
          total_time += wait_hours + assembly_hours

          log "Processing #{item['name']}: Arrival Days: #{arrival_days}, Assembly Hours: #{assembly_hours}, Total Time: #{total_time}"
        end

        total_time
      end
    end

    if __FILE__==$PROGRAM_NAME
      (puts "Usage: ruby #{$0} (json-file) (algorithm)"; exit) unless ARGV.length > 0
      json_file_name = ARGV[0]
      algorithm = ARGV[1] || 'spt'
      begin
        input = JSON.parse(File.read(json_file_name))
      rescue
        puts "Error: Invalid JSON file - #{json_file_name}"
        exit
      end
      puts "Using algorithm: #{algorithm}"
      calculator = AssemblyPlanning.new(input, true)
      puts "Input array: #{calculator.input.inspect}"
      puts "Result: #{calculator.send(algorithm)}"
    end

## Credits and References

* [RIOT: The Scheduling Problem](https://riot.ieor.berkeley.edu/Applications/Scheduling/algorithms.html)
* [Single-machine scheduling](https://en.wikipedia.org/wiki/Single-machine_scheduling)
* [Integrated Production, Control Systems: Management, Analysis, and Design](https://www.goodreads.com/book/show/2193350.Integrated_Production_Control_Systems) by David D. Bedworth, James E. Bailey. First published January 1, 1987.
