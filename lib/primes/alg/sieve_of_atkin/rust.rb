# frozen_string_literal: true

require_relative "base"

module Primes
  module Alg
    # impliment Sieve of Atkin algorithm to compute primes
    module SieveOfAtkin
      # rust engine
      # rust code here: rust/primes/sieve_of_atkin.rs
      class Rust < Base
        # find all primes <= max
        # => run it count times
        def run
          RUST.sieve_of_atkin(limit, count)
        end

        def demo_fallback
          # demonstrate what happens when rust panics
          RUST.make_rust_panic
        end

        def self.display_name
          "Sieve of Atkin"
        end

        def lang
          "rust"
        end

        def self.lang
          "rust"
        end
      end
    end
  end
end
