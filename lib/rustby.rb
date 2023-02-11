# frozen_string_literal: true

require_relative "rustby/version"
require_relative "primes/mod"

module Rustby
  class Error < StandardError; end

  p "== Welcome to rustby == " \
    " Pure Ruby vs Rust Embedded in Ruby Using rutie (github/danielpclark/rutie)"

  # find all primes less than or equal to n in each language
  # => run each program k times
  # => return results
  Primes::Benchmarker.run(
    alg_str: 'sieve_of_atkin',
    n: 1_000_000,
    k: 5
  )

end
