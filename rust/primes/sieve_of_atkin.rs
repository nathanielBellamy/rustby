use crate::primes::PrimesResult;
use rutie::Integer;
use std::error;
use std::fmt;

#[derive(Debug, Clone)]
pub struct SieveOfAtkin {
    pub limit: u64,
    pub count: u64,
}

impl fmt::Display for SieveOfAtkin {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "AN ERROR OCCURRED IN RUST_PRIMES_SIEVE_OF_ATKIN")
    }
}

impl error::Error for SieveOfAtkin {}

impl SieveOfAtkin {
    pub fn new(lim: Integer, ct: Integer) -> SieveOfAtkin {
        SieveOfAtkin {
            limit: lim.to_u64(),
            count: ct.to_u64(),
        }
    }

    pub fn run(&self) -> PrimesResult {
        let mut results: Vec<i64> = vec![];
        for _ in 1..self.count + 1 {
            results = self.sieve_of_atkin()?;
        }
        Ok(results)
    }

    pub fn sieve_of_atkin(&self) -> PrimesResult {
        let mut sieve: Vec<bool> = vec![false; (self.limit + 1) as usize]; // assumed composite until proven prime
        let max_xy: u64 = ((self.limit as f64).sqrt() + 1.0).ceil() as u64;
        for x in 1..max_xy {
            for y in 1..max_xy {
                let mut n = 4 * x.pow(2) + y.pow(2);
                if n <= self.limit && (n % 12 == 1 || n % 12 == 5) {
                    // println!("{:?}", sieve);
                    sieve[n as usize] = !sieve[n as usize]
                }

                n = 3 * x.pow(2) + y.pow(2);
                if n <= self.limit && n % 12 == 7 {
                    sieve[n as usize] = !sieve[n as usize]
                }

                n = 3 * x.pow(2) - y.pow(2);
                if x > y && n <= self.limit && n % 12 == 11 {
                    sieve[n as usize] = !sieve[n as usize]
                }
            }
        }

        for n in 5..max_xy {
            if sieve[n as usize] {
                // n prime
                for k in (n.pow(2)..self.limit).step_by(n.pow(2) as usize) {
                    // mark multiples of n^2 as composite
                    sieve[k as usize] = false
                }
            }
        }

        let mut primes: Vec<i64> = vec![2, 3];
        for (n, is_prime) in sieve.iter().enumerate() {
            if *is_prime {
                primes.push(n as i64);
            }
        }

        Ok(primes)
    }
}
