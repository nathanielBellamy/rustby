# frozen_string_literal: true

module SieveOfAtkin
  # engine base
  # TODO: abstract into base to be shared between algorithm modules
  class Base
    attr_reader :max, :count

    def initialize(max = 2, count = 2)
      @max = max
      @count = count
    end
  end
end
