# frozen_string_literal: true

require_relative "base"

module Primes
  module Alg
    # impliment the Naive algorithm to compute primes
    module Naive
      # => use pure ruby
      #   => iterate through natural numbers up to n
      #   => check if number is divisible by any of the previously found primes
      #   => if not, add it to the list of primes
      class Ruby < Base
        def run
          results = []
          (1..@count).each do
            results = naive
          end
          results
        end

        # rubocop:disable Metrics/MethodLength
        def naive
          primes = [2]
          (3..@limit).each do |n|
            is_prime = true # assume prime
            primes.each do |prime|
              if (n % prime).zero? # until proven composite
                is_prime = false
                break
              end
            end
            primes.push(n) if is_prime
          end
          primes
        end
        # rubocop:enable Metrics/MethodLength

        def self.display_name
          "Naive"
        end

        def lang
          "ruby"
        end

        def self.lang
          "ruby"
        end
      end
    end
  end
end
