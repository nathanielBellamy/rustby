# frozen_string_literal: true

require "benchmark"
require_relative "sieve_of_atkin/ruby"
require_relative "sieve_of_atkin/rust"
require_relative "../user_io/cli"

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
    # TODO: refactor to appease rubocop
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def run
      raise PrimesError, "Please select an algorithm to benchmark." if alg == ""

      Benchmark.bm do |x|
        UserIO::Cli.ruby_marker
        ruby_res = []
        rust_res = []
        x.report do
          (1..count).each do
            ruby_res = alg::Ruby.new(limit).run
          end
          UserIO::Cli.lang_res(ruby_res, limit, count)
        end
        UserIO::Cli.rust_marker
        x.report do
          (1..count).each do
            rust_res = alg::Rust.new(limit).run
          end
          UserIO::Cli.lang_res(ruby_res, limit, count)
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

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
