# frozen_string_literal: true

require_relative "../base"

# impliment the Naive algorithm to compute primes
module Naive
  # => use pure ruby
  # => iterate through natural numbers n, divide and check
  class Ruby < Primes::Base
    # def run
    #   primes = [2]
    #   (3..limit).each do |n|
    #     is_prime = false
    #     max_divisor = (limit**0.5).ceil
    #     (2..max_divisor).each do |d|
    #       if (n / d).ceil == (n / d)
    #   end
    # end
  end
end
