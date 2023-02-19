require "tty-spinner"

module Primes
    # provide cli functionality
  class Cli
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

    def welcome
      p "                      === Welcome to 🦀rustby🐝 == "
      p "              === Build in #{ruby_marker}. Optimize in #{rust_marker}. ==="
      p "                === thx. to github/danielpclark/rutie === "
    end

    # rubocop:disable Metrics/MethodLength
    def benchmarking_intro
      p divider
      welcome
      pause(5, effect: true)
      divider_with_space
      p " We will be finding primes up to #{limit}."
      p " We will run each computation #{count} time(s) in both Ruby and Rust."
      p " We will compare results provided by Ruby's Benchmark class."
      divider_with_space
      pause(5, effect: true)
    end

    def pause(duration, effect: false)
      spinner_1 = TTY::Spinner.new(format: :bouncing_ball)
      p " === Pausing For Effect === " if effect
      spinner_1.auto_spin
      sleep duration
      spinner_1.success("")
    end

    def fallback_intro
      p divider
      welcome
      p divider_with_space
      pause(3, effect: true)
      p "🦀rustby🐝 provides a Fallbacker class that:"
      p " => allows computation in Rust with a failsafe to Ruby"
      p " => Fallbacker accepts a Ruby module MyMod (e.g. Primes::Alg::SieveOfAtkin)"
      p " => this module should contain both a Ruby and Rust Class (e.g. MyMod::Ruby, MyMod::Rust)"
      p "     => both classes should use the same initializer (likely inherited from a base class)"
      p "     => the Ruby class can impliment the algorithm in Ruby in the class definition"
      p "     => the Rust class impliments a method by the same name which wraps a method defined on the RUST class"
      p " => the goal of Fallbacker is to make 🦀rustby🐝 as safe as Pure Ruby"
      p " => you can write all of your code in Ruby and selectively optimize into Rust, without sacrificing safety"
      p divider_with_space
      pause(10, effect: true)

      p " To demonstrate, we will call the Fallbacker class as follows:"
      p ""
      p " => Services::Fallbacker.new(            "
      p "        mod: Primes::Alg::SieveOfAtkin,  "
      p "         func: demo_fallback,            "
      p "          args: {                        "
      p "           limit: cli.limit,             "
      p "           count: cli.count              "
      p "          }                              "
      p "       )                                 "
      p empty_line
      pause(10, effect: true)
      p " In this case, the Fallbacker flow is:"
      p " => Fallbacker calls"
      p "        Primes::Alg::SieveOfAtkin::Rust.demo_fallback(limit: limit, count: count)"
      p " => this method wraps a call to RUST.make_rust_panic, which does as the name implies "
      p " => Rust code will catch this panic and return an error to Ruby"
      p " => Fallbacker receives the error and completes the computation by calling"
      p "        Primes::Alg::SieveOfAtkin::Rust.demo_fallback(limit: limit, count: count) "
      p empty_line
      pause(10, effect: true)
      p " After the computation has run, you should see a Rust error reported to the console:"
      p "     thread '<unnamed>' panicked at 'RUST PANIC!', rust/test/panic_on_purpose.rs:7:9"
      p "     note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace"
      p " as well as the full results, that will have been computed in Ruby."
      p divider_with_space
      pause(5, effect: true)
      p " Let's see it in action:"
      p " ...3"
      pause(1)
      p " ...2"
      pause(1)
      p " ...1"
      pause(1)
      p " !GO!"
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
      divider_with_space
      p "                     🐝💎🦀 Thanks for stopping by! 🦀💎🐝"
      divider_with_space
    end
    # rubocop:enable Metrics/MethodLength

    def divider_with_space
      p empty_line
      p empty_line
      p divider
      p divider
      p empty_line
      p empty_line
    end

    def divider
      " ====================================================================="
    end

    def empty_line
      ""
    end

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
