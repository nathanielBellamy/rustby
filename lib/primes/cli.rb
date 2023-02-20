require "tty-spinner"
require_relative "../../lib/cli/mod"

module Primes
    # provide cli functionality
  class Cli < Cli::Base
    attr_reader :limit, :alg_str, :count, :mod

    def initialize(args)
      limit = args[:limit].to_i
      limit_invalid =  limit < 2
      @limit = limit_invalid ? 1_000 : limit
      @alg_str = args[:alg_str] || "sieve_of_atkin"
      @count = args[:count].to_i == 0 ? 1 : args[:count].to_i
    end

    def args
      @args ||= { limit: @limit,
                  alg_str: @alg_str,
                  count: @count }
    end

    # rubocop:disable Metrics/MethodLength
    def benchmarking_intro
      p divider
      p "🦀rustby🐝 provides a Benchmarker class:"
      p "  => a thin wrapper to the standard Benchmark class in Ruby"
      p "  => designed specifically to compare the performance of Ruby and Rust"
      pause(5, effect: true)
      divider_with_space
      p " To demonstrate.."
      pause(1)
      p " We will be finding primes up to #{limit}."
      p " We will run each computation #{count} time(s) in both Ruby and Rust."
      p " We will compare results provided by Ruby's Benchmark class."
      divider_with_space
      pause(5, effect: true)
    end

    def fallback_intro
      p divider
      p divider_with_space
      p "🦀rustby🐝 provides a Fallbacker class that:"
      p " => allows computation in Rust with a failsafe to Ruby"
      p " => Fallbacker accepts a Ruby module MyMod (e.g. Primes::Alg::SieveOfAtkin)"
      p " => this module contain both a Ruby and Rust Class -- MyMod::Ruby, MyMod::Rust"
      p " => Fallbacker will first perform the computation in Rust"
      p "     => if anything goes wrong, it performs it in Ruby"
      p " with the idea to:"
      p "     => write all code in Ruby"
      p "     => selectively optimize into Rust when performance matters"
      p "     => sting when it counts"
      p divider_with_space
      pause(20, effect: true)

      p " To demonstrate, we will call the Fallbacker class as follows:"
      p ""
      p " => Services::Fallbacker.new(            "
      p "      mod: Primes::Alg::SieveOfAtkin,    "
      p "      func: demo_fallback,               "
      p "      args: {                            "
      p "        limit: #{limit},              "
      p "        count: #{count}               "
      p "      }                                  "
      p "     )                                   "
      p empty_line
      pause(15, effect: true)
      p " In this case, the Fallbacker flow is:"
      p " => Fallbacker calls"
      p "        Primes::Alg::SieveOfAtkin::Rust.demo_fallback(limit: #{limit}, count: #{count}) (🦀)"
      p " => this method would generally wrap a call to a computational method on the RUST class"
      p " => for the purposes of this demonstration, it wraps a call to RUST.make_rust_panic"
      p " => Rust code will catch this panic and return an error to Ruby"
      p " => Fallbacker receives the error and completes the computation by calling"
      p "        Primes::Alg::SieveOfAtkin::Ruby.demo_fallback(limit: #{limit}, count: #{count}) (💎)"
      p empty_line
      pause(15, effect: true)
      p " After the computation has run, you should see a Rust error reported to the console:"
      p "     thread '<unnamed>' panicked at 'RUST PANIC!', rust/test/panic_on_purpose.rs:7:9"
      p "     note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace"
      p " as well as the full results, that will have been computed in Ruby."
      p divider_with_space
      pause(10, effect: true)
      p " Let's see it in action:"
      p " ...3"
      pause(1)
      p " ...2"
      pause(1)
      p " ...1"
      pause(1)
      p " GO "
      p empty_line
      p empty_line
    end

    def outro_message
      p empty_line
      p empty_line
      divider_with_space
      p " You should see above the results comparing the performance of Pure Ruby and Embedded Rust."
      p " This testing uses the Benchmark.bmbm method, which runs the tests twice:"
      p "    => First it runs a Rehearsal, which establishes the environment. "
      p "       Without this phase, Ruby's memory allocation and garbage collection may hinder"
      p "       the performance of the first benchmark, which is Ruby in our case."
      p "    => The second result is the more accurate, although some variance is inevitable."
      p " On my system I see Rust outperforming Ruby by a substantial margin on both passes."
      pause(10)
      outro
    end
    # rubocop:enable Metrics/MethodLength

    def benchmarking
      p " Benchmarking..."
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
      p ""
      p ""
      p "#{lang_marker} found #{result.count} primes <= #{limit}"
      if limit < 25
        p result
      else
        p "[... #{result[-5, 5]&.join(", ")}]"
      end
      p "It did so #{count} times using the #{alg_str} algorithm built in #{lang_marker} ."
      p ""
      p ""
    end

    def full_res(lang:, result:)
      lang_marker = lang == "ruby" ? ruby_marker : rust_marker

      p ""
      p "**********************"
      p "#{lang_marker}"
      p "**********************"

      p result
    end

    def ruby_marker
      "💎RUBY"
    end

    def rust_marker
      "🦀RUST"
    end
  end
end
