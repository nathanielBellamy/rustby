# frozen_string_literal: true

require "benchmark"
require_relative "sieve_of_atkin/ruby"
require_relative "sieve_of_atkin/rust"

module Primes
  class PrimesError < StandardError; end

  # measure run time of different algorithms
  class Benchmarker
    attr_reader :alg_str, :limit, :count

    def initialize(alg_str: "", limit: 2, count: 5)
      @alg_str = alg_str
      @limit = limit
      @count = count
    end

    # execute and time algorithm to find all primes <= limit
    # => run the algorithm count times in each language and take average
    # => compare results between ruby and rust
    def run
      raise PrimesError, "Please select an algorithm to benchmark." if alg == ""

      Benchmark.bm do |x|
        p "=====RUBY"
        x.report { alg::Ruby.run(limit) }
        p "=====RUST"
        x.report { alg::Rust.run(limit) }
      end
    end

    def alg
      case alg_str
      when "sieve_of_atkin", "soa"
        @alg ||= SieveOfAtkin
      else
        raise PrimesError,
              <<~HEREDOC
                We have not yet implemented the algorithm you have entered.
                Please try another.
              HEREDOC
      end
    end
  end
end
