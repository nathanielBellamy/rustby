# frozen_string_literal: true

require "benchmark"


require_relative "../user_io/cli"
require_relative "base"

# require Ruby and Rust implimentations
require_relative "sieve_of_atkin/ruby.rb"
require_relative "sieve_of_atkin/rust.rb"
require_relative "naive/ruby.rb"
require_relative "naive/rust.rb"

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
      raise PrimesError, "Please select an algorithm to benchmark." if alg == ""

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
      UserIO::Cli.lang_res("ruby", ruby_res, limit, count)
      UserIO::Cli.lang_res("rust", rust_res, limit, count)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def alg
      case alg_str
      when "sieve_of_atkin", "soa", "s"
        @alg ||= SieveOfAtkin
      when "naive", "n"
        @alg ||= Naive
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
