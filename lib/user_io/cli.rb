# frozen_string_literal: true

module UserIO
  # provide cli functionality
  class Cli
    attr_reader :limit, :alg_str, :count

    def initialize(argv)
      @limit = argv[0].to_i || 1_000
      @alg_str = argv[1] || "sieve_of_atkin"
      @count = argv[2].nil? ? 1 : argv[2].to_i
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
      p divider
      p divider
      p empty_line
      p empty_line
      p " We will be finding primes up to #{@limit}."
      p " We will run each computation #{@count} time(s) in both Ruby and Rust."
      p " We will then gather the data provided by Ruby's Benchmark class and compare results."
    end
    # rubocop:enable Metrics/MethodLength

    def divider
      " ====================================================================="
    end

    def empty_line
      ""
    end

    def self.lang_res(res, limit, count)
      p "Found #{res.count} primes <= #{limit} and did so #{count} times."
    end

    def self.ruby_marker
      p " =============💎RUBY💎"
    end

    def self.rust_marker
      p " =============🦀RUST🦀"
    end
  end
end
