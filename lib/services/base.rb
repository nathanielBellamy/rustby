# frozen_string_literal: true

module Services
  # load ruby and rust modules
  class Base
    attr_reader :rust_mod, :ruby_mod
    def initialize(ruby_mod, rust_mod)
      @ruby_mod = ruby_mod
      @rust_mod = rust_mod
    end
  end
end
