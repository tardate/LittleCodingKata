#include <cassert>
#include <typeinfo>
#include <cstdio>
#include <iostream>
#include "sml.hpp"

namespace sml = boost::sml;


struct state_machine_logger {
  template <class SM, class TEvent>
  void log_process_event(const TEvent&) {
    printf("[%s][process_event] %s\n", typeid(SM).name(), typeid(TEvent).name());
  }

  template <class SM, class TGuard, class TEvent>
  void log_guard(const TGuard&, const TEvent&, bool result) {
    printf("[%s][guard] %s %s %s\n", typeid(SM).name(), typeid(TGuard).name(), typeid(TEvent).name(),
           (result ? "[OK]" : "[Reject]"));
  }

  template <class SM, class TAction, class TEvent>
  void log_action(const TAction&, const TEvent&) {
    printf("[%s][action] %s %s\n", typeid(SM).name(), typeid(TAction).name(), typeid(TEvent).name());
  }

  template <class SM, class TSrcState, class TDstState>
  void log_state_change(const TSrcState& src, const TDstState& dst) {
    printf("[%s][transition] %s -> %s\n", typeid(SM).name(), src.c_str(), dst.c_str());
  }
};


namespace {

  // An Event is just a unique type:
  struct e1 {};
  struct e2 {
    bool value = true;
  };
  // Event e3 is created on the fly.
  struct e4 {
    int value = 0;
  };

  // event instance in order to simplify transition table notation:
  auto event2 = sml::event<e2>;

  struct events {
    auto operator()() const noexcept {
      using namespace sml;

      // Guards callable objects which will be executed by the state machine in order to verify whether a transition,
      // followed by an action should take place. Guard MUST return boolean value.
      auto guard = [](const e2& e) { return e.value; };
      auto exit_guard = [](const e4& e) { return 42 == e.value; };

      // When we have states and events handy we can finally create a transition table which represents our transitions with a UML-like DSL
      return make_transition_table( // using Postfix Notation
        // Initial state tells the state machine where to start. It can be set by prefixing a State with *.
        // e1 will transition to s1
        *"idle"_s + event<e1> = "s1"_s

        // e2 will transition s1 to s2 if guard is true
        , "s1"_s + event2 [guard] = "s2"_s

        // e3 will transition s2 to s3
        , "s2"_s + "e3"_e = "s3"_s

        // e4 will transition s3 to X if guard is true and run action
        , "s3"_s + event<e4> [exit_guard] / [] (const auto& e) { assert(42 == e.value); } = X
      );
    }
  };
}


int main() {
  using namespace sml;

  std::cout << "// create state machine with logger" << std::endl;
  state_machine_logger my_logger;
  sml::sm<events, sml::logger<state_machine_logger>> sm{my_logger}; // instead of just `sml::sm<events> sm;`

  std::cout << "// e2: ignored: e2 can't transition from initial idle state" << std::endl;
  sm.process_event(e2{});

  std::cout << "// e1: transitions to s1" << std::endl;
  sm.process_event(e1{});

  std::cout << "// e2{false}: fails s1 to s2 guard condition" << std::endl;
  sm.process_event(e2{false});
  std::cout << "// e2{}: passes s1 to s2 guard condition" << std::endl;
  sm.process_event(e2{});

  std::cout << "// e3: on-the-fly event transitions from s2 to s3" << std::endl;
  sm.process_event("e3"_e());

  std::cout << "// e4{33}: fails s3 exit guard" << std::endl;
  sm.process_event(e4{33});
  std::cout << "// e4{42}: spasses s3 guard and transitions to terminate state X" << std::endl;
  sm.process_event(e4{42});

  // SML supports terminate state, which stops events to be processed. It defined by X.
  assert(sm.is(X));

  std::cout << "// ignored - state machine has terminated" << std::endl;
  sm.process_event(e4{42});
}
