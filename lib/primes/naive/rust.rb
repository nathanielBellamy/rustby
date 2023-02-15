# frozen_string_literal: true

require_relative "../base"

# impliment the Naive algorithm to compute primes
module Naive
  # => use rust
  #   => iterate through natural numbers up to n
  #   => check if number is divisible by any of the previously found primes
  #   => if not, add it to the list of primes
  class Rust < Primes::Base
    def run
      RUST.naive(limit, count)
    end
  end
end
