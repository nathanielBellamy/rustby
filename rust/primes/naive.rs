use crate::primes::PrimesResult;
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
    pub fn new(lim: u64, ct: u64) -> Naive {
        Naive {
            limit: lim,
            count: ct,
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

        for n in 3..self.limit + 1 {
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

#[cfg(test)]
mod naive_spec {
    use super::*;
    #[test]
    #[allow(non_snake_case)]
    fn run__returns_vec_containing_2_when_limit_is_2() {
        let naive = Naive::new(2, 1);
        match naive.run() {
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
        let naive = Naive::new(1_000, 1);
        match naive.run() {
            Err(_) => panic!(),
            Ok(res_vec) => {
                assert_eq!(168, res_vec.len());
                assert_eq!(2_i64, res_vec[0]);
            }
        }
    }

    #[test]
    #[allow(non_snake_case)]
    fn run__finds_all_primes_to_10k() {
        let naive = Naive::new(10_000, 1);
        match naive.run() {
            Err(_) => panic!(),
            Ok(res_vec) => {
                assert_eq!(1229, res_vec.len());
                assert_eq!(2_i64, res_vec[0]);
                assert_eq!(9973_i64, res_vec[1228]);
            }
        }
    }
}
