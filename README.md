# 🦀rustby🐝

### 💎 Ruby w. Embedded Rust 🦀

#### Build in Ruby  ->  Optimize (Sting) with Rust  ->  Fall Back on Ruby (if it doesn't work out)

##### built with [rutie](https://github.com/danielpclark/rutie)

## intro to 🦀rustby🐝

- Build in [Ruby](https://www.ruby-lang.org/en/)
  - maintain full functionality in Ruby
- Optimize in [Rust](https://www.rust-lang.org/)
  - translate performance sensitive operations into Rust
- Fallback on Ruby
  - if there is any error in Rust, default to performing the computation in Ruby

### why 🦀rustby🐝

- the speed of Rust when you need it
- the safety of Ruby always

### to run:

- `rake --tasks`
- `rake spec:run`
  - runs `rspec` and `cargo test`
  - builds rust before running `rspec`

#### primes

  - primes is the example module around which 🦀rustby🐝 has been built
  - algorithms to compute primes have been constructed in both ruby and rust
  - args
    - `{limit} - 💎Integer, 🦀u64`
      - compute all primes less than or equal to
      - increase to stress test memory usage
    - `{count} - 💎Integer, 🦀u64`
      - run the computation this many times
      - increase to stress test computation
    - `{alg_str} - 💎String`
      - select algorithm for computation
      - can be:
        - `sieve_of_at, soa, s`
        - `naive, n`

##### demo 🦀rustby🐝 using primes

- `rake primes:demo:benchmark`
- `rake primes:demo:fallback`

##### compute using 💎ruby

 - `rake primes:ruby:main {limit} {alg_str}`
 - `rake primes:ruby:sieve_of_atkin {limit}`
 - `rake primes:ruby:naive {limit}`

##### compute using 🦀rust

 - `rake primes:rust:main {limit} {alg_str}`
 - `rake primes:rust:sieve_of_atkin {limit}`
 - `rake primes:rust:naive {limit}`

##### benchmark performance: 💎ruby vs. 🦀rust

 - `rake primes:benchmark:sieve_of_atkin {limit} {count}`
 - `rake primes:benchmark:sieve_of_atkin {limit} {count}`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
