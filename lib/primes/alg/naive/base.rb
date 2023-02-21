# frozen_string_literal: true

module Primes
  module Alg
    module Naive
      # parent class for ::Ruby and ::Rust classes
      class Base
        attr_reader :alg_str, :limit, :count

        def initialize(limit: 2, count: 1)
          @alg_str = "naive"
          @limit = limit
          @count = count
        end

        def self.public_run(limit: 2, count: 1)
          lang_class = new(limit: limit, count: count)
          lang_class.run
        end
      end
    end
  end
end
