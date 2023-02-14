# 🦀 rustby 🐝

### 🦀 Rust Within Ruby 💎

#### to run:

- `ruby ./lib/rustby.rb limit algorithm count`
  - e.g. `ruby ./lib/rustby.rb 12345 sieve_of_atkin 1000`
  - `limit` : find all primes less than or equal to this number
    - default: `2`
  - `algorithm` : choose how you want to find said primes
    - at the moment only `sieve_of_atkin` (`soa` for short) is supported
    - default: `soa`
  - `count` : run computation this many times in each language (useful for benchmarking)
    - default: `1`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
