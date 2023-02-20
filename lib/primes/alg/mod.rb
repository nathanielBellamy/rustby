# frozen_string_literal: true

require_relative "naive/mod"
require_relative "sieve_of_atkin/mod"

module Primes
  module Alg
    def self.mod(alg_str)
      case alg_str
      when "sieve_of_atkin", "soa", "s"
        Primes::Alg::SieveOfAtkin
      when "naive", "n"
        Primes::Alg::Naive
      else
        raise PrimesError, "We have not yet implemented that algorithm. Please try another."
      end
    end
  end
end
