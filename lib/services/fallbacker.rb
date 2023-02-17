# frozen_string_literal: true

require_relative "../../user_io/cli"
require_relative "base"

# require algorithm module implimentations
require_relative "../alg/mod"

module Services
  # run algorithm in rust
  # fallback to ruby algorithm if rust errors
  # TODO: handle a pure rust panic!()
  class Fallbacker < Services::Base
    def run(func: "", args: {})
      begin
        # run in rust
        results = rust_mod.send(func, args)

        if Rustby::Error.is_rust_error(results) # if rust fails
          results = ruby_mod.send(func, args)
        end

        return results unless results.nil?
        raise Services::Error, "Fallbacker: Neither Rust nor Ruby produced a result" if results.nil?

      rescue => e
        raise Services::Error, "Fallbacker: #{e}"
      end
    end
  end
end
