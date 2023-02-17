#[macro_use]
extern crate rutie;

use crate::error::rust_error::RustError;
use rutie::{Array, Integer};
use rutie::{Class, Object};
use std::error::Error;
use std::panic;

mod error;

mod primes;
use crate::primes::naive::Naive;
use crate::primes::sieve_of_atkin::SieveOfAtkin;

mod ruby_io;
use crate::ruby_io::ruby_array::RubyArray;

class!(RUST);

methods!(
    RUST,
    _rtself,
    fn naive(lim: Integer, ct: Integer) -> Array {
        // returns either
        // => RutieArray [2, 3, 5,...]
        // => RutieArray ["RUST ERROR", "Naive: Rust Panic"]
        #[allow(unused)] // conditionally re-assigned
        let mut results: Vec<i64> = vec![];
        match panic::catch_unwind(|| {
            // wrap rust computation to catch panic
            match Naive::new(
                lim.expect("Naive: Bad Limit"),
                ct.expect("Naive: Bad Count"),
            )
            .run()
            {
                Ok(primes) => primes, // return Vec<i64> of primes to Unwind boundary
                Err(_) => vec![],     //  return empty vec
                                       // TODO: log rust error from rust
            }
        }) {
            Ok(primes) => results = primes, // store results outside of Unwind
            Err(_) => {
                let err: Box<dyn Error> = String::from("Naive: Rust Panic").into();
                return RustError::new(err);
            }
        }

        RubyArray::from_vec_i64(results)
    },
    fn sieve_of_atkin(lim: Integer, ct: Integer) -> Array {
        // returns either
        // => RutieArray [2, 3, 5,...]
        // => RutieArray ["RUST ERROR", "Naive: Rust Panic"]
        #[allow(unused)] // conditionally re-assigned
        let mut results: Vec<i64> = vec![];
        match panic::catch_unwind(|| {
            // wrap rust computation to catch panic
            match SieveOfAtkin::new(
                lim.expect("SieveOfAtkin: Bad Limit"),
                ct.expect("SieveOfAtkin: Bad Count"),
            )
            .run()
            {
                Ok(primes) => primes,
                Err(_) => vec![],
            }
        }) {
            Ok(primes) => results = primes, // capture primes if success
            Err(_) => {
                // return RustError if not
                let err: Box<dyn Error> = String::from("Naive: Rust Panicked").into();
                return RustError::new(err);
            }
        }

        RubyArray::from_vec_i64(results)
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
