#[macro_use]
extern crate rutie;

use rutie::Array;
use rutie::Integer;
use rutie::RString;
use rutie::{Class, Object};

class!(RUST);

methods!(
    RUST,
    _rtself,
    fn hello(_input: RString) -> RString {
        RString::new_utf8("!!!HELLO FROM RUST!!!")
    },
    fn sieve_of_atkin(lim: Integer) -> Array {
        let limit: u64 = lim.unwrap().to_u64();
        let mut sieve: Vec<bool> = vec![false; limit as usize]; // assumed composite until proven prime
        let max_xy: u64 = ((limit as f64).sqrt() + 1.0).ceil() as u64;
        for x in 1..max_xy {
            for y in 1..max_xy {
                let mut n = 4 * x.pow(2) + y.pow(2);
                if n <= limit && (n % 12 == 1 || n % 12 == 5) {
                    sieve[n as usize] = !sieve[n as usize]
                }

                n = 3 * x.pow(2) + y.pow(2);
                if n <= limit && n % 12 == 7 {
                    sieve[n as usize] = !sieve[n as usize]
                }

                n = 3 * x.pow(2) - y.pow(2);
                if x > y && n <= limit && n % 12 == 11 {
                    sieve[n as usize] = !sieve[n as usize]
                }
            }
        }

        for n in 5..max_xy {
            if sieve[n as usize] {
                // n prime
                for k in (n.pow(2)..limit).step_by(n.pow(2) as usize) {
                    // mark multiples of n^2 as composite
                    sieve[k as usize] = false
                }
            }
        }

        let mut sieve_results = Array::new();
        for (n, is_prime) in sieve.iter().enumerate() {
            if *is_prime {
                sieve_results.push(Integer::new(n as i64));
            }
        }

        let mut primes = Array::new();
        primes.push(Integer::new(2_i64));
        primes.push(Integer::new(3_i64));

        primes.concat(&sieve_results)
    }
);

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_rustby() {
    Class::new("RUST", None).define(|klass| {
        klass.def_self("hello", hello);
        klass.def_self("sieve_of_atkin", sieve_of_atkin);
    });
}
