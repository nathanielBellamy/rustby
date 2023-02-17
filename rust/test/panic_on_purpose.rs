#[allow(unused)]
pub struct PanicOnPurpose {}

impl PanicOnPurpose {
    #[allow(unused)]
    pub fn now() {
        panic!("RUST PANIC!")
    }
}
