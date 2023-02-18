require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  namespace :benchmark do
    desc "Demo Benchmarking Rust and Ruby Performance" \
          "  =>  rake primes:benchmark:demo"
    task :demo do
      suppress_input_as_tasks
      Rustby.init_rust

      cli = Primes::Cli.new(
        limit: 5_432_10,
        alg_string: 'sieve_of_atkin',
        count: 10
      )

      cli.intro_message
      cli.benchmarking

      results = Services::Benchmarker.new(
        mod: Primes::Alg::SieveOfAtkin,
        func: "public_run",
        args: {
          limit: cli.limit,
          count: cli.count
        },
      ).run

      cli.lang_res(lang: 'ruby', result: results[:ruby])
      cli.lang_res(lang: 'rust', result: results[:rust])
    end

    desc "Find Primes Using the Sieve of Atkin Algorithm" \
         "  =>  rake primes:benchmark:sieve_of_atkin {limit} {count}"
    task :sieve_of_atkin do
      suppress_input_as_tasks
      Rustby.init_rust

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: "sieve_of_atkin",
        count: ARGV[2]
      )

      cli.benchmarking

      results = Services::Benchmarker.new(
        mod: Primes::Alg::SieveOfAtkin,
        func: "public_run",
        args: {
          limit: cli.limit,
          count: cli.count
        },
      ).run

      cli.lang_res(lang: 'ruby', result: results[:ruby])
      cli.lang_res(lang: 'rust', result: results[:rust])
    end

    desc "Find Primes Using a Naive Algorithm" \
          "  =>  rake primes:naive {limit} {count}"
    task :naive do
      suppress_input_as_tasks
      Rustby.init_rust

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_str: "naive",
        count: ARGV[2]
      )

      cli.benchmarking

      results = Services::Benchmarker.new(
        mod: Primes::Alg::Naive,
        func: "public_run",
        args: {
          limit: cli.limit,
          count: cli.count
        },
      ).run

      cli.lang_res(lang: 'ruby', result: results[:ruby])
      cli.lang_res(lang: 'rust', result: results[:rust])
    end
  end

  def suppress_input_as_tasks
    # prevents errors of the form:
    #   rake aborted!
    #   Don't know how to build task {cli_input} (See the list of available tasks with `rake --tasks`)
    ARGV.each { |a| task a.to_sym {} }
  end
end
