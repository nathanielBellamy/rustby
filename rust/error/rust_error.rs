use rutie::{Array, RString};

pub struct RustError {}

impl RustError {
    //
    // Rust code should handle and log its own errors
    //   in the event that Rust does error or panic
    //   it should return an Array of Rstrings to Ruby:
    //      ["RUST_ERROR", "Error: my_error"]
    //
    //
    #[allow(clippy::new_ret_no_self)]
    pub fn new(message: &'static str) -> Array {
        let mut error = Array::new();
        error.push(RString::new_utf8("RUST_ERROR"));
        let err = format!("Error: {}", message);
        error.push(RString::new_utf8(&err));
        error
    }
}
