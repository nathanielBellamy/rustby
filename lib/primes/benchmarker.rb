# frozen_string_literal: true

require "benchmark"
require_relative "../user_io/cli"
require_relative "base"

# require algorithm module implimentations
require_relative "sieve_of_atkin/mod"
require_relative "naive/mod"

module Primes
  # measure run time of different algorithms
  class Benchmarker
    include Naive
    include SieveOfAtkin
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

      ruby_res = []
      rust_res = []

      Benchmark.bmbm do |x|
        x.report(UserIO::Cli.ruby_marker) do
          ruby_res = alg::Ruby.new(limit, count).run
        end

        x.report(UserIO::Cli.rust_marker) do
          rust_res = alg::Rust.new(limit, count).run
        end
      end

      p ""
      p ""
      UserIO::Cli.lang_res(alg::Ruby, ruby_res, limit, count)
      UserIO::Cli.lang_res(alg::Rust, rust_res, limit, count)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def alg
      case alg_str
      when "sieve_of_atkin", "soa", "s"
        @alg ||= SieveOfAtkin
      when "naive", "n"
        @alg ||= Naive
      else
        raise Primes::Error,
              UserIO::Cli.alg_not_found
      end
    end
  end
end
