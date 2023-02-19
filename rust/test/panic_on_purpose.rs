#[allow(unused)]
pub struct PanicOnPurpose {}

impl PanicOnPurpose {
    #[allow(unused)]
    pub fn now() {
        panic!("RUST PANIC ON PURPOSE!")
    }
}

#[cfg(test)]
mod panic_on_purpose_spec {
    use super::*;
    use std::panic;

    #[test]
    #[allow(non_snake_case)]
    fn now__causes_panic() {
        match panic::catch_unwind(PanicOnPurpose::now) {
            Ok(_) => panic!("Fail Test: PanicOnPurpose::now() Did Not Cause Panic"),
            Err(_) => assert_eq!(true, true),
        }
    }
}
