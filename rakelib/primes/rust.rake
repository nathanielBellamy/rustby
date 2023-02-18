require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  namespace :rust do
    desc "Find primes using the SieveOfAtkin Algorithm Built in Rust " \
          "  =>  rake primes:rust:sieve_of_atkin {limit}"
    task :sieve_of_atkin do
      suppress_input_as_tasks
      Rustby.init_rust

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: 'sieve_of_atkin',
        count: 1
      )

      res = Primes::Alg::SieveOfAtkin::Rust.new(
        limit: cli.limit,
        count: cli.count
      ).run

      cli.full_res(lang: 'rust', result: res)
    end

    desc "Find primes using the Naive Algorithm Built in Rust " \
          "  =>  rake primes:rust:naive {limit}"
    task :naive do
      suppress_input_as_tasks
      Rustby.init_rust

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: 'naive',
        count: 1
      )

      res = Primes::Alg::Naive::Rust.new(
        limit: cli.limit,
        count: cli.count
      ).run

      cli.full_res(lang: 'rust', result: res)
    end

  end
end
