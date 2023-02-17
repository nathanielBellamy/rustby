use std::error::Error;
pub type PrimesResult = Result<Vec<i64>, Box<dyn Error>>;

pub mod naive;
pub mod sieve_of_atkin;
