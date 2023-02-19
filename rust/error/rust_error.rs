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

#[cfg(test)]
mod rust_error_spec {

    #[test]
    #[allow(non_snake_case)]
    fn new__returns_rutie_array_of_length_2() {
        // TODO: debug using rutie::VM::int() in multiple tests
        // right now, causes segmentation fault
        // on the bright-side, highlighted that prime structs
        // should not depend on rutie

        // let res = RustError::new("Oh no!");

        // assert_eq!(2, res.length());
        // assert_eq!("[\"RUST_ERROR\", \"Error: Oh no!\"]", res.to_s().to_str());
    }
}
