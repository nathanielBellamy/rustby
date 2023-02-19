use std::error::Error;
pub type PrimesResult = Result<Vec<i64>, Box<dyn Error>>;

pub mod naive;
pub mod sieve_of_atkin;

#[cfg(test)]
mod primes_spec {

    use crate::primes::naive::Naive;
    use crate::primes::sieve_of_atkin::SieveOfAtkin;

    #[test]
    fn finds_same_primes_to_20k_using_naive_and_sieve_of_atkin_algorithm() {
        let naive_res = Naive::new(20_000, 1).run().unwrap();
        let soa_res = SieveOfAtkin::new(20_000, 1).run().unwrap();

        let res_len = naive_res.len();
        assert_eq!(res_len, soa_res.len());

        for i in 1..res_len {
            assert_eq!(naive_res[i], soa_res[i]);
        }
    }
}
