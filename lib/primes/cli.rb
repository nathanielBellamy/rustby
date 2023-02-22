# frozen_string_literal: true

require "tty-spinner"
require_relative "../../lib/cli/mod"

module Primes
  # provide cli functionality

  # rubocop:disable Metrics/ClassLength
  # TODO: impliment i18n
  class Cli < Cli::Base
    attr_reader :limit, :alg_str, :count, :mod

    def initialize(args)
      limit = args[:limit].to_i
      limit_invalid = limit < 2
      @limit = limit_invalid ? 1_000 : limit
      @alg_str = args[:alg_str] || "sieve_of_atkin"
      @count = args[:count].to_i.zero? ? 1 : args[:count].to_i
    end

    def args
      @args ||= {
        limit: @limit,
        alg_str: @alg_str,
        count: @count
      }
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def benchmarking_intro(demo: false)
      if demo
        empty_lines
        puts <<-HEREDOC
              🦀rustby🐝 Benchmarker
                => a thin wrapper to the standard Benchmark class in Ruby
                => designed specifically to compare the performance of Ruby and Rust
        HEREDOC
        pause(5, effect: true)
        empty_lines
        puts " To demonstrate:"
        pause(1)
      end
      puts <<-HEREDOC
            1. Find primes up to #{limit}.
            2. Run each computation #{count} time(s) in both Ruby and Rust.
            3. Record and display performance data using Ruby's Benchmark class.
      HEREDOC
      empty_lines
      pause(5, effect: true)
      empty_lines
      puts "   GO   "
      empty_lines
    end

    def fallback_intro
      empty_lines
      puts <<-HEREDOC
             🦀rustby🐝 Fallbacker
                => sting with Rust
                => fallback on Ruby
      HEREDOC
      empty_lines
      puts " To demonstrate:"
      pause(5)
      puts <<-HEREDOC
         Will make the following call:
                Services::Fallbacker.new(
                  mod: Primes::Alg::SieveOfAtkin,
                  func: demo_fallback,
                  args: {
                    limit: #{limit},
                    count: #{count}
                  }
                )
      HEREDOC
      empty_lines
      pause(15, effect: true)
      puts <<-HEREDOC
         In this case, the flow is:

          1. Fallbacker calls
                `Primes::Alg::SieveOfAtkin::Rust.demo_fallback(limit: #{limit}, count: #{count})` (🦀)

          2. such a method on the ::Rust class should wrap a computational method on the RUST bridge class

          3. for the purposes of this demonstration, it wraps a call to `RUST.make_rust_panic`

          4. Rust code in `rust/lib.rs` will catch this panic and return an error to Ruby

          5. Fallbacker receives the error and completes the computation by calling
                 `Primes::Alg::SieveOfAtkin::Ruby.demo_fallback(limit: #{limit}, count: #{count})` (💎)
      HEREDOC
      empty_line
      pause(20, effect: true)
      puts <<-HEREDOC
         After the computation has run, you should see a Rust error reported to the console:

             thread '<unnamed>' panicked at 'RUST PANIC!', rust/test/panic_on_purpose.rs:7:9

         You should also see the full results that will have been computed in Ruby.
      HEREDOC
      empty_lines
      pause(12, effect: true)
      puts <<-HEREDOC
         Let's see it in action:
      HEREDOC
      puts " ...3"
      pause(1)
      puts " ...2"
      pause(1)
      puts " ...1"
      pause(1)
      puts " GO "
      empty_lines
    end

    def benchmarking_outro
      empty_lines
      empty_lines
      puts <<-HEREDOC
        You should see above the results comparing the performance of Pure Ruby and Embedded Rust.
        This testing uses the Benchmark.bmbm method, which runs the tests twice:
             => First it runs a Rehearsal, which establishes the environment.
                   Without this phase, Ruby's memory allocation and garbage collection may hinder
                   the performance of the first benchmark, which is Ruby in our case.
             => The second result is the more accurate, although some variance is inevitable.
        On my system I see Rust outperforming Ruby by a substantial margin on both passes.
      HEREDOC
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    def benchmarking
      empty_lines
      puts "      Benchmarking..."
    end

    def self.alg_not_found
      <<~HEREDOC
        We have not yet implemented the algorithm you have entered.
        So far we have:
          - Sieve of Atkin
            - rake primes:main {limit} sieve_of_atkin {count}
            - rake primes:main {limit} s {count}
          - Sieve of Naive
            - rake primes:main {limit} naive {count}
            - rake primes:main {limit} n {count}
      HEREDOC
    end

    def lang_res(lang:, result:)
      lang_marker = lang == "ruby" ? ruby_marker : rust_marker
      empty_lines
      puts "#{lang_marker} found #{result.count} primes <= #{limit}"
      if limit < 25
        puts result
      else
        puts "[... #{result[-5, 5]&.join(", ")}]"
      end
      puts "It did so #{count} times using the #{alg_str} algorithm built in #{lang_marker} ."
      empty_lines
    end

    def full_res(lang:, result:)
      lang_marker = lang == "ruby" ? ruby_marker : rust_marker
      empty_lines
      puts <<-HEREDOC
                  **********************
                         #{lang_marker}
                  **********************
      HEREDOC
      puts result
      empty_lines
    end
  end
  # rubocop:enable Metrics/ClassLength
end
