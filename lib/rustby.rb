# frozen_string_literal: true

require_relative "cli/mod"
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
    Rake::Task['main'].execute
  end
end
