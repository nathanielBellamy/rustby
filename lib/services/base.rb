# frozen_string_literal: true

module Services
  # load ruby and rust modules
  class Base
    attr_reader :cli, :rust_class, :ruby_class, :func, :args

    def initialize(mod:, func:, args: {}, cli: DefaultCli)
      @ruby_class = mod::Ruby
      @rust_class = mod::Rust
      @func = func
      @args = args
      @cli = cli
    end
  end

  class DefaultCli
    def self.ruby_marker
      "💎RUBY"
    end

    def self.rust_marker
      "🦀RUST"
    end

    def self.lang_res(lang_class:, result:)
      lang_marker = lang_class.lang == "ruby" ? self.ruby_marker : self.rust_marker
      p ""
      p "****************************"
      p "       #{lang_marker}"
      p "****************************"
    end
  end
end
