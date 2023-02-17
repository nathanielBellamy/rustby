#[macro_use]
extern crate rutie;

use crate::error::rust_error::RustError;
use rutie::{Array, Integer};
use rutie::{Class, Object};
use std::error::Error;

mod error;

mod primes;
use crate::primes::naive::Naive;
use crate::primes::sieve_of_atkin::SieveOfAtkin;

mod test;

class!(RUST);

methods!(
    RUST,
    _rtself,
    fn naive(lim: Integer, ct: Integer) -> Array {
        match Naive::new(lim.unwrap(), ct.unwrap()).run() {
            Ok(array) => array,
            Err(e) => RustError::new(e),
        }
    },
    fn sieve_of_atkin(lim: Integer, ct: Integer) -> Array {
        match SieveOfAtkin::new(lim.unwrap(), ct.unwrap()).run() {
            Ok(array) => array,
            Err(e) => RustError::new(e),
        }
    },
    fn rust_error() -> Array {
        let err: Box<dyn Error> = String::from("You made Rust panic!").into();
        RustError::new(err)
    }
);

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_rustby() {
    Class::new("RUST", None).define(|klass| {
        klass.def_self("naive", naive);
        klass.def_self("sieve_of_atkin", sieve_of_atkin);
        klass.def_self("rust_error", rust_error);
    });
}
