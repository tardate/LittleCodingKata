pub fn create_laundry_item() -> LaundryItem {
  LaundryItem {
    cycle: LaundryState::Ready
  }
}

#[derive(Debug)]
pub struct LaundryItem {
    cycle: LaundryState
}

impl LaundryItem {
    pub fn next_cycle(&mut self) -> String {
        self.cycle = match self.cycle  {
            LaundryState::Ready => LaundryState::Soak,
            LaundryState::Soak => LaundryState::Wash,
            LaundryState::Wash => LaundryState::Rinse,
            LaundryState::Rinse => LaundryState::Spin,
            LaundryState::Spin => LaundryState::Dry,
            LaundryState::Dry => LaundryState::Done,
            LaundryState::Done => LaundryState::Done
        };
        format!("{:?}", &self.cycle).to_lowercase()
    }
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
enum LaundryState {
    Ready,
    Soak,
    Wash,
    Rinse,
    Spin,
    Dry,
    Done
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn create_laundry_item_returns_expected_object() {
        let obj = create_laundry_item();
        assert_eq!(obj.cycle, LaundryState::Ready);
    }

    #[test]
    fn create_laundry_next_cycle_transitions_states_correctly() {
        let mut obj = create_laundry_item();
        assert_eq!(obj.next_cycle(), "soak");
        assert_eq!(obj.next_cycle(), "wash");
        assert_eq!(obj.next_cycle(), "rinse");
        assert_eq!(obj.next_cycle(), "spin");
        assert_eq!(obj.next_cycle(), "dry");
        assert_eq!(obj.next_cycle(), "done");
        assert_eq!(obj.next_cycle(), "done");
        assert_eq!(obj.cycle, LaundryState::Done);
    }
}
