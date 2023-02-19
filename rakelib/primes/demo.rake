require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  namespace :demo do
    desc  "💎🦀=>  rake primes:demo:benchmark  =>  " \
          "Demo Benchmarking Rust and Ruby Performance Using Primes"
    task :benchmark do
      suppress_input_as_tasks
      Rustby.init_rust

      cli = Primes::Cli.new(
        limit: 5_432_10,
        alg_string: 'sieve_of_atkin',
        count: 10
      )

      cli.benchmarking_intro
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

    desc "💎🦀=>  rake primes:demo:fallback  =>  " \
         "Demo Fallback from Rust to Ruby Using Primes"
    task :fallback do
      suppress_input_as_tasks
      Rustby.init_rust

      cli = Primes::Cli.new(
        limit: 1500,
        alg_string: 'sieve_of_atkin',
        count: 1
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
    end
  end
end
