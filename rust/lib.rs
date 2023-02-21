#[macro_use]
extern crate rutie;

use crate::error::rust_error::RustError;
use rutie::{Array, Integer};
use rutie::{Class, Object};

use std::panic;

mod error;
mod primes;
use crate::primes::naive::Naive;
use crate::primes::sieve_of_atkin::SieveOfAtkin;

mod ruby_io;
use crate::ruby_io::ruby_array::RubyArray;

mod test;
use crate::test::panic_on_purpose::PanicOnPurpose;

// the class to which Rub will have access
class!(RUST);

// define RUST class which Ruby can access
//  => functions here wrap main rust code
//  => functions here call their underlying rust function wrapped in panic::catch_unwind
//  => if the underlying function panics, the function here catches+handles a Result::Err
//  => if any error occurs, functions here return RustError::new(my_message)
//  => rustby checks for RustErrors using Rustby.rust_error?(my_result)
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
                // handle rust errors in rust
                lim.expect("Naive: Bad Limit").to_u64(),
                ct.expect("Naive: Bad Count").to_u64(),
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
                return RustError::new("Naive: Rust Panic");
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
                // handle rust errors in rust
                lim.expect("SieveOfAtkin: Bad Limit").to_u64(),
                ct.expect("SieveOfAtkin: Bad Count").to_u64(),
            )
            .run()
            {
                Ok(primes) => primes,
                Err(_) => vec![],
            }
        }) {
            Ok(primes) => results = primes, // store results outside of Unwind
            Err(_) => {
                return RustError::new("Naive: Rust Panicked");
            }
        }

        RubyArray::from_vec_i64(results)
    },
    // test functions
    fn rust_error() -> Array {
        RustError::new("YOU MADE RUST RETURN AN ERROR")
    },
    fn make_rust_panic() -> Array {
        if panic::catch_unwind(PanicOnPurpose::now).is_err() {
            RustError::new("YOU MADE RUST PANIC")
        } else {
            // this code should never be reached
            RustError::new("YOU DID NOT MAKE RUST PANIC")
        }
    }
);

#[allow(non_snake_case)]
#[no_mangle]
// expose RUST class and its methods to Ruby
pub extern "C" fn Init_rustby() {
    Class::new("RUST", None).define(|klass| {
        klass.def_self("naive", naive);
        klass.def_self("sieve_of_atkin", sieve_of_atkin);
        klass.def_self("rust_error", rust_error);
        klass.def_self("make_rust_panic", make_rust_panic);
    });
}

#[cfg(test)]
mod lib_spec {

    #[test]
    #[allow(non_snake_case)]
    fn lib__is_here() {
        assert_eq!(true, true);
    }
}
