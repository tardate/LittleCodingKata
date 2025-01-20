# #079 [Boost].SML

Initial tests with [Boost].SML - a C++14 State Machine Library.

## Notes

[Boost].SML is a C++14 State Machine Library delivered in a single header file with no dependencies.

It provides a pattern for defining events, guards and states. The transition table is described with an eUML style DSL.

## Installation

It's a single file:

    wget https://raw.githubusercontent.com/boost-experimental/sml/master/include/boost/sml.hpp

## Events Example

See [events.cpp](./events.cpp) for a trivial example that experiments with the library.
See the source for my annotations that clarify (read: helped me learn) how it fits together.

The output traces the state transitions (successful and failed):

    $ make
    c++ -std=c++17 -g -Wall -O3    events.cpp   -o events
    $ ./events
    // create state machine with logger
    // e2: ignored: e2 can't transition from initial idle state
    [N12_GLOBAL__N_16eventsE][process_event] N12_GLOBAL__N_12e2E
    // e1: transitions to s1
    [N12_GLOBAL__N_16eventsE][process_event] N12_GLOBAL__N_12e1E
    [N12_GLOBAL__N_16eventsE][transition] idle -> s1
    // e2{false}: fails s1 to s2 guard condition
    [N12_GLOBAL__N_16eventsE][process_event] N12_GLOBAL__N_12e2E
    [N12_GLOBAL__N_16eventsE][guard] ZNK12_GLOBAL__N_16eventsclEvEUlRKNS_2e2EE_ N12_GLOBAL__N_12e2E [Reject]
    // e2{}: passes s1 to s2 guard condition
    [N12_GLOBAL__N_16eventsE][process_event] N12_GLOBAL__N_12e2E
    [N12_GLOBAL__N_16eventsE][guard] ZNK12_GLOBAL__N_16eventsclEvEUlRKNS_2e2EE_ N12_GLOBAL__N_12e2E [OK]
    [N12_GLOBAL__N_16eventsE][transition] s1 -> s2
    // e3: on-the-fly event transitions from s2 to s3
    [N12_GLOBAL__N_16eventsE][process_event] N5boost3sml6v1_1_03aux6stringIcJLc101ELc51EEEE
    [N12_GLOBAL__N_16eventsE][transition] s2 -> s3
    // e4{33}: fails s3 exit guard
    [N12_GLOBAL__N_16eventsE][process_event] N12_GLOBAL__N_12e4E
    [N12_GLOBAL__N_16eventsE][guard] ZNK12_GLOBAL__N_16eventsclEvEUlRKNS_2e4EE_ N12_GLOBAL__N_12e4E [Reject]
    // e4{42}: spasses s3 guard and transitions to terminate state X
    [N12_GLOBAL__N_16eventsE][process_event] N12_GLOBAL__N_12e4E
    [N12_GLOBAL__N_16eventsE][guard] ZNK12_GLOBAL__N_16eventsclEvEUlRKNS_2e4EE_ N12_GLOBAL__N_12e4E [OK]
    [N12_GLOBAL__N_16eventsE][transition] s3 -> terminate
    [N12_GLOBAL__N_16eventsE][action] ZNK12_GLOBAL__N_16eventsclEvEUlRKT_E_ N12_GLOBAL__N_12e4E
    // ignored - state machine has terminated
    [N12_GLOBAL__N_16eventsE][process_event] N12_GLOBAL__N_12e4E

## Credits and References

* [[Boost].SML](https://boost-experimental.github.io/sml)
* [[Boost].SML](https://github.com/boost-experimental/sml) - github
