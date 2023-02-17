# frozen_string_literal: true

module Services
  # load ruby and rust modules
  class Base
    attr_reader :rust_class, :ruby_class, :func, :args

    def initialize(mod:, func:, args: {})
      @ruby_class = mod::Ruby
      @rust_class = mod::Rust
      @func = func
      @args = args
    end
  end
end
