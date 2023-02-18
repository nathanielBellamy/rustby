# frozen_string_literal: true

require_relative "rustby/version"
require_relative "services/mod"
require_relative "primes/mod"
require "rutie"

# An Implimentation of Rust Within Ruby
module Rustby
  class Error < StandardError
    def self.is_rust_error(err)
      res = false
      begin
        # rust should handle errors internally
        # and return array: ["RUST_ERROR", "Error: my_error"]
        res = err[0] == "RUST_ERROR"
      rescue
        # arrive here if err does not impliment []
        # not a rust error in this case
      end

      res
    end

  end

  def self.init_rust
    # init rust bridge
    Rutie.new(:rustby).init "Init_rustby", __dir__
  end

  def self.main(cli)
    self.init_rust

    cli.intro_message
    cli.benchmarking
    # find all primes less than or equal to limit in each language
    # => run each program k times
    # => return results
    Primes::Services::Benchmarker.new(
      alg_str: cli.args[:alg_str],
      limit: cli.args[:limit],
      count: cli.args[:count]
    ).run

    cli.outro_message
  end
end
