require 'benchmark'
require_relative 'sieve_of_atkin/ruby'
require_relative 'sieve_of_atkin/rust'

module Primes
  class PrimesError < StandardError; end

  class Benchmarker
    attr_accessor :alg, :n, :k

    # execute and time algorithm to find all primes <= n
    #   =>run the algorithm k times in each language and take average
    def self.run(alg_str: '', n: 2, k: 5)
      @n = n
      raise PrimesError, "Please select an algorithm to benchmark." if alg_str == ''

      case alg_str
      when 'sieve_of_atkin', 'soa'
        @alg = SieveOfAtkin
      else
        raise PrimesError, <<~HEREDOC
                                We either could not find or have yet
                                to implement the algorithm you have entered
                                Please try another.
                              HEREDOC
      end


      Benchmark.bm do |x|
        x.report { @alg::Ruby.new(n: n, k: k).run }
        x.report { @alg::Rust.new(n: n, k: k).run }
      end
    end
  end
end
