# frozen_string_literal: true

require_relative "../base"

# impliment Sieve of Atkin algorithm to compute primes
module SieveOfAtkin
  # rust engine
  # rust code here: rust/primes/sieve_of_atkin.rs
  class Rust < Primes::Base
    # find all primes <= max
    # => run it count times
    def run
      RUST.sieve_of_atkin(limit, count)
    end

    def self.display_name
      "Sieve of Atkin"
    end

    def self.lang
      "rust"
    end
  end
end
