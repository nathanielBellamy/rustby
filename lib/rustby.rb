# frozen_string_literal: true

require_relative "rustby/version"
require_relative "primes/mod"

# An Implimentation of Rust Within Ruby
module Rustby
  class Error < StandardError; end

  p " == Welcome to rustby == " \
    " == Rust Embedded in Ruby Using rutie (github/danielpclark/rutie) === "

  # find all primes less than or equal to n in each language
  # => run each program k times
  # => return results
  Primes::Benchmarker.new(
    alg_str: "sieve_of_atkin",
    max: 1_000_000,
    count: 5
  ).run
end
