# frozen_string_literal: true

module Primes
  # algorithm engine base
  class Base
    attr_reader :limit, :count

    def initialize(limit = 2, count = 1)
      @limit = limit
      @count = count
    end
  end
end
