# frozen_string_literal: true

module SieveOfAtkin
  # engine base
  # TODO: abstract into base to be shared between algorithm modules
  class Base
    attr_reader :limit

    def initialize(limit = 2)
      @limit = limit
    end
  end
end
