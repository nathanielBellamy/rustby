# frozen_string_literal: true

require_relative "base"

module Services
  # run algorithm in rust
  # fallback to ruby algorithm if rust errors
  class Fallbacker < Services::Base
    def run
      # run in rust
      results = rust_class.send(func, **args)

      # if rust fails
      results = ruby_class.send(func, **args) if Rustby::Error.rust_error?(results)

      return results unless results.nil?

      raise Services::Error, "Fallbacker: Neither Rust nor Ruby produced a result"
    end
  end
end
