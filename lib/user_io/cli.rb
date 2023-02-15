# frozen_string_literal: true

module UserIO
  # provide cli functionality
  class Cli
    attr_reader :limit, :alg_str, :count

    def initialize(argv)
      @limit = argv[1].nil? ? 1_000 : argv[1].to_i
      @alg_str = argv[2] || "sieve_of_atkin"
      @count = argv[3].nil? ? 2 : argv[2].to_i
    end

    def args
      @args ||= { limit: @limit,
                  alg_str: @alg_str,
                  count: @count }
    end

    # rubocop:disable Metrics/MethodLength
    def intro_message
      p divider
      p divider
      p "                      === Welcome to rustby == "
      p "                  === 🦀Rust🦀 Embedded in 💎Ruby💎 === "
      p "                === thx. to github/danielpclark/rutie === "
      divider_with_space
      p " We will be finding primes up to #{@limit}."
      p " We will run each computation #{@count} time(s) in both Ruby and Rust."
      p " We will then gather the data provided by Ruby's Benchmark class and compare results."
      divider_with_space
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

    def self.lang_res(lang, res, limit, count)
      lang_marker = lang == "ruby" ? self.ruby_marker : self.rust_marker
      p "#{lang_marker} found #{res.count} primes <= #{limit} and did so #{count} times."
      if limit > 5
        p "[... #{res[-3, 3].join(", ")}]"
      end
    end

    def self.ruby_marker
      "💎RUBY"
    end

    def self.rust_marker
      "🦀RUST"
    end
  end
end
