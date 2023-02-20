require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  namespace :demo do
    desc  "💎🦀=>  rake primes:demo:benchmark  =>  " \
          "Demo Benchmarking Rust and Ruby Performance Using Primes"
    task :benchmark do
      init_task(rust: true)

      cli = Primes::Cli.new(
        limit: 5_432_10,
        alg_string: 'sieve_of_atkin',
        count: 10
      )

      cli.benchmarking_intro(demo: true)
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

      cli.benchmarking_outro
      cli.outro
    end

    desc "💎🦀=>  rake primes:demo:fallback  =>  " \
         "Demo Fallback from Rust to Ruby Using Primes"
    task :fallback do
      init_task(rust: true)

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: 'sieve_of_atkin',
        count: ARGV[2]
      )

      cli.fallback_intro

      results = Services::Fallbacker.new(
        mod: Primes::Alg::SieveOfAtkin,
        func: "demo_fallback",
        args: {
          limit: cli.limit,
          count: cli.count
        }
      ).run

      cli.full_res(lang: 'ruby', result: results)

      cli.outro
    end
  end
end
