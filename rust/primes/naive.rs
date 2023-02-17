use crate::primes::PrimesResult;
use rutie::Integer;
use std::error;
use std::fmt;

#[derive(Debug, Clone)]
pub struct Naive {
    pub limit: u64,
    pub count: u64,
}

impl fmt::Display for Naive {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "AN ERROR OCCURRED IN RUST_PRIMES_NAIVE")
    }
}

impl error::Error for Naive {}

impl Naive {
    pub fn new(lim: Integer, ct: Integer) -> Naive {
        Naive {
            limit: lim.to_u64(),
            count: ct.to_u64(),
        }
    }

    pub fn run(&self) -> PrimesResult {
        let mut results: Vec<i64> = vec![];
        for _ in 1..self.count + 1 {
            results = self.naive()?;
        }
        Ok(results)
    }

    pub fn naive(&self) -> PrimesResult {
        let mut primes: Vec<i64> = vec![2];

        for n in 3..self.limit {
            let mut is_prime = true; // assume prime
            for prime in &primes {
                if n as i64 % *prime == 0 {
                    // until prove composite
                    is_prime = false;
                    break;
                }
            }
            if is_prime {
                primes.push(n as i64);
            }
        }

        Ok(primes)
    }
}
