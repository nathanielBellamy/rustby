# frozen_string_literal: true

module Primes
  module Alg
    module Naive
      class Base
        attr_reader :alg_str, :limit, :count

        def initialize(limit: 2, count: 1)
          @alg_str = "naive"
          @limit = limit
          @count = count
        end

        def self.public_run(limit: 2, count: 1)
          lang_class = self.new(limit: limit, count: count)
          lang_class.run
        end
      end
    end
  end
end
