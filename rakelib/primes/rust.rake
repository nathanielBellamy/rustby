require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  namespace :rust do
    desc "🦀=>  rake primes:rust:sieve_of_atkin {limit}  =>  " \
         "Find primes using the given algorithm built in 🦀Rust"
    task :main do
      suppress_input_as_tasks

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: ARGV[2],
        count: 1
      )

      res = Primes::Alg::SieveOfAtkin::Ruby.new(
        limit: cli.limit,
        count: cli.count
      ).run

      cli.full_res(lang: 'ruby', result: res)
    end

    desc "🦀=>  rake primes:rust:sieve_of_atkin {limit}  =>  " \
         "Find primes using the Sieve Of Atkin algorithm built in 🦀Rust"
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

    desc "🦀=>  rake primes:rust:naive {limit}  =>  " \
         "Find primes using a naive algorithm built in 🦀Rust " \

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
