# frozen_string_literal: true

require_relative "base"

module Primes
  module Alg
    # impliment the Naive algorithm to compute primes
    module Naive
      # => use rust
      #   => iterate through natural numbers up to n
      #   => check if number is divisible by any of the previously found primes
      #   => if not, add it to the list of primes
      class Rust < Base
        def run
          RUST.naive(limit, count)
        end

        def self.display_name
          "Naive"
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
