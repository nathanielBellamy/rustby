# frozen_string_literal: true

require_relative "base"

module SieveOfAtkin
  # find all primes <= limit
  # => run it k times
  # => use pure ruby
  # => translate python algorithm from here: https://stackoverflow.com/questions/21783160/sieve-of-atkin-implementation-in-python
  class Ruby < Base
    def self.run(limit)
      primes = [2,3] # init prime list
      sieve = (0..limit + 1).map{ || false } # initially mark all numbers as composite
      (1..(limit**0.5)+1).each do |x|
        (1..(limit**0.5)+1).each do |y|
          n = 4*(x**2) + y**2
          sieve[n] = !sieve[n] if self.alg_3_1_conditions(n, limit)
          n = 3*(x**2) + y**2
          sieve[n] = !sieve[n] if self.alg_3_2_conditions(n, limit)
          n= 3*(x**2) - y**2
          sieve[n] = !sieve[n] if x > y && self.alg_3_3_conditions(n, limit)
        end
      end

      (5..(limit**0.5).ceil).each do |n|
        if sieve[n] # n is prime
          (n**2..limit).step(n**2).each do |k| # eliminate multiples of prime^2
            sieve[k] = false
          end
        end
      end

      sieve_res = sieve.map.with_index{ |is_prime, idx| idx if is_prime }.compact

      primes.concat(sieve_res)
    end

    def self.alg_3_1_conditions(n, limit)
      n <= limit && (n % 12 == 1 || n % 12 == 5)
    end

    def self.alg_3_2_conditions(n, limit)
      n <= limit && n % 12 == 7
    end

    def self.alg_3_3_conditions(n, limit)
      n <= limit && n % 12 == 11
    end
  end
end
