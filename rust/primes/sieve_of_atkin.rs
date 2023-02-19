use crate::primes::PrimesResult;
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
    pub fn new(lim: u64, ct: u64) -> SieveOfAtkin {
        SieveOfAtkin {
            limit: lim,
            count: ct,
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
        if self.limit == 2 {
            return Ok(vec![2]);
        }

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

                // k used to avoid 'attempt to subtract with overflow'
                let k: i64 = 3 * x.pow(2) as i64 - y.pow(2) as i64;
                n = k as u64;
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

#[cfg(test)]
mod sieve_of_atkin_spec {
    use super::*;

    #[test]
    #[allow(non_snake_case)]
    fn run__returns_vec_containing_2_when_limit_is_2() {
        let soa = SieveOfAtkin::new(2, 1);
        match soa.run() {
            Err(_) => panic!(),
            Ok(res_vec) => {
                assert_eq!(1, res_vec.len());
                assert_eq!(2_i64, res_vec[0]);
            }
        }
    }

    #[test]
    #[allow(non_snake_case)]
    fn run__returns_primes_result_ok_containing_vec_i64() {
        let soa = SieveOfAtkin::new(3, 1);
        match soa.run() {
            Err(_) => panic!(),
            Ok(res_vec) => {
                assert_eq!(2, res_vec.len());
                assert_eq!(2_i64, res_vec[0]);
                assert_eq!(3_i64, res_vec[1]);
            }
        }
    }

    #[test]
    #[allow(non_snake_case)]
    fn run__finds_all_primes_to_10k() {
        let soa = SieveOfAtkin::new(10_000, 1);
        match soa.run() {
            Err(_) => panic!(),
            Ok(res_vec) => {
                assert_eq!(1229, res_vec.len());
                assert_eq!(2_i64, res_vec[0]);
                assert_eq!(9973_i64, res_vec[1228]);
            }
        }
    }
}
