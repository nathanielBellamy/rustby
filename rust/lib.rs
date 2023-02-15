#[macro_use]
extern crate rutie;

use rutie::{Array, Integer};
use rutie::{Class, Object};

mod primes;
use crate::primes::naive::Naive;
use crate::primes::sieve_of_atkin::SieveOfAtkin;

class!(RUST);

methods!(
    RUST,
    _rtself,
    fn naive(lim: Integer, ct: Integer) -> Array {
        Naive::new(lim.unwrap(), ct.unwrap()).run()
    },
    fn sieve_of_atkin(lim: Integer, ct: Integer) -> Array {
        SieveOfAtkin::new(lim.unwrap(), ct.unwrap()).run()
    }
);

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_rustby() {
    Class::new("RUST", None).define(|klass| {
        klass.def_self("naive", naive);
        klass.def_self("sieve_of_atkin", sieve_of_atkin);
    });
}
