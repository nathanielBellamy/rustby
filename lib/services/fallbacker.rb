# frozen_string_literal: true

require_relative "../user_io/cli"
require_relative "base"

module Services
  # run algorithm in rust
  # fallback to ruby algorithm if rust errors
  class Fallbacker < Services::Base
    def run
      begin
        # run in rust
        results = rust_class.send(func, **args)

        if Rustby::Error.is_rust_error(results) # if rust fails
          results = ruby_class.send(func, **args)
        end

        return results unless results.nil?
        raise Services::Error, "Fallbacker: Neither Rust nor Ruby produced a result"
      rescue => e
        raise Services::Error, "Fallbacker: #{e}"
      end
    end
  end
end
