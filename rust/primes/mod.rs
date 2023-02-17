use rutie::Array;
use std::error::Error;

pub type PrimesResult = Result<Array, Box<dyn Error>>;

pub mod naive;
pub mod sieve_of_atkin;
