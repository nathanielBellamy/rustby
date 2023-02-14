# frozen_string_literal: true

require_relative "base"

module SieveOfAtkin
  # find all primes <= limit
  # => run it k times
  # => use pure ruby
  # => translate python algorithm from here: https://stackoverflow.com/questions/21783160/sieve-of-atkin-implementation-in-python
  class Ruby < Base
    # TODO: refactor to appease rubocop
    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    def run
      sieve = (0..limit + 1).map { false } # initially mark all numbers as composite
      max_xy = ((limit**0.5) + 1).ceil
      (1..max_xy).each do |x|
        (1..max_xy).each do |y|
          n = 4 * (x**2) + y**2
          sieve[n] = !sieve[n] if alg_conditions_1(n)
          n = 3 * (x**2) + y**2
          sieve[n] = !sieve[n] if alg_conditions_2(n)
          n = 3 * (x**2) - y**2
          sieve[n] = !sieve[n] if x > y && alg_conditions_3(n)
        end
      end

      (5..(limit**0.5).ceil).each do |n|
        next unless sieve[n] # next unless n is currently labeled prime

        (n**2..limit).step(n**2).each do |k| # eliminate multiples of n^2
          sieve[k] = false
        end
      end

      sieve.map.with_index { |is_prime, idx| idx if is_prime }.compact
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

    # rubocop:disable Naming/MethodParameterName
    def alg_conditions_1(n)
      n <= limit && (n % 12 == 1 || n % 12 == 5)
    end

    def alg_conditions_2(n)
      n <= limit && n % 12 == 7
    end

    def alg_conditions_3(n)
      n <= limit && n % 12 == 11
    end
    # rubocop:enable Naming/MethodParameterName
  end
end
