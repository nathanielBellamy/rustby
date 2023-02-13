# frozen_string_literal: true

require_relative "base"

module SieveOfAtkin
  # rust engine
  class Rust < Base
    # find all primes <= max
    # => run it count times
    def self.run(limit)
      # TODO
      p RUST.hello
    end
  end
end
