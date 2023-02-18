# frozen_string_literal: true

require "benchmark"
require_relative "base"

module Services
  # measure run time of different algorithms
  class Benchmarker < Services::Base
    # run both the ruby module and the rust module
    # compare performance
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def run
      ruby_res = nil
      rust_res = nil

      Benchmark.bmbm do |x|
        x.report(cli.ruby_marker) do
          ruby_res = ruby_class.send(func, **args)
        end

        x.report(cli.rust_marker) do
          rust_res = rust_class.send(func, **args)
        end
      end

      cli.lang_res(lang_class: ruby_class, result: ruby_res)
      cli.lang_res(lang_class: rust_class, result: rust_res)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
end
