# frozen_string_literal: true

require_relative "rustby/version"
require_relative "primes/benchmarker"
require_relative "user_io/cli"
require "rutie"

# An Implimentation of Rust Within Ruby
module Rustby
  class Error < StandardError; end

  # init rust bridge
  Rutie.new(:rustby).init "Init_rustby", __dir__

  cli = UserIO::Cli.new(ARGV)
  cli.intro_message

  UserIO::Cli.benchmarking
  # find all primes less than or equal to limit in each language
  # => run each program k times
  # => return results
  Primes::Benchmarker.new(
    alg_str: cli.args[:alg_str],
    limit: cli.args[:limit],
    count: cli.args[:count]
  ).run

  cli.outro_message
end
