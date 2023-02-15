# 🦀 rustby 🐝

### 🦀 Rust Within Ruby 💎

#### to run:

- `rake primes:main {limit} {algorithm} {count}`
  - e.g. `rake primes:main 12345 sieve_of_atkin 1000`
  - `limit` : find all primes less than or equal to this number
    - default: `2`
  - `algorithm` : choose how you want to find said primes
    - at the moment only `sieve_of_atkin` (`soa` for short) is supported
    - default: `soa`
  - `count` : run computation this many times in each language (useful for benchmarking)
    - default: `1`

- `rake primes:sieve_of_atkin {limit} {count}`
  - explicitly run Sieve of Atkin algorithm

- `rake primes:naive {limit} {count}`
  - explicitly run Naive algorithm

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
