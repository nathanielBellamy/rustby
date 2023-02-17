# frozen_string_literal: true

require "benchmark"
require_relative "../user_io/cli"
require_relative "base"

module Services
  # measure run time of different algorithms
  class Benchmarker < Services::Base
    # run both the ruby module and the rust module
    # compare performance
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def run(func: "", args: {})
      ruby_res = nil
      rust_res = nil

      Benchmark.bmbm do |x|
        x.report(UserIO::Cli.ruby_marker) do
          ruby_res = ruby_mod.send(func, args)
        end

        x.report(UserIO::Cli.rust_marker) do
          rust_res = rust_mod.send(func, args)
        end
      end

      p ""
      p ""
      UserIO::Cli.lang_res(ruby_mod, ruby_res, limit, count)
      UserIO::Cli.lang_res(rust_mod, rust_res, limit, count)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
end
