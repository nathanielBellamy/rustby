use rutie::{Array, Integer};

pub struct Naive {
    pub limit: u64,
    pub count: u64,
}

impl Naive {
    pub fn new(lim: Integer, ct: Integer) -> Naive {
        Naive {
            limit: lim.to_u64(),
            count: ct.to_u64(),
        }
    }

    pub fn run(&self) -> Array {
        let mut results = Array::new();
        for _ in 1..self.count + 1 {
            results = self.naive();
        }
        results
    }

    pub fn naive(&self) -> Array {
        let mut primes: Vec<u64> = vec![2];

        for n in 3..self.limit {
            let mut is_prime = true; // assume prime
            for prime in &primes {
                if n % prime == 0 {
                    // until prove composite
                    is_prime = false;
                    break;
                }
            }
            if is_prime {
                primes.push(n);
            }
        }

        // prep output to be returned to ruby
        let mut ruby_primes = Array::new();
        for prime in primes {
            ruby_primes.push(Integer::new(prime as i64));
        }
        ruby_primes
    }
}
