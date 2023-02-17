use rutie::{Array, RString};
use std::error::Error;

pub struct RustError {}

impl RustError {
    //
    // Rust code should handle errors
    //   in the event that Rust does error or panic
    //   it should return an Array of Rstrings to Ruby:
    //      ["RUST_ERROR", "Error: my_error"]
    //
    //
    pub fn new(e: Box<dyn Error>) -> Array {
        let mut error = Array::new();
        error.push(RString::new_utf8("RUST_ERROR"));
        let err = format!("Error: {}", e);
        error.push(RString::new_utf8(&err));
        error
    }
}
