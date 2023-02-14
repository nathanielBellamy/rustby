# frozen_string_literal: true

require_relative "base"

module SieveOfAtkin
  # rust engine
  class Rust < Base
    # find all primes <= max
    # => run it count times
    def run
      RUST.sieve_of_atkin(limit)
    end
  end
end
