require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  desc "🦀=>  rake primes:ruby {limit} {alg_str}  =>  " \
       "Find primes using given algorithm built in 🦀Rust"
  task :rust do
    init_task(rust: true)

    cli = Primes::Cli.new(
      limit: ARGV[1],
      alg_string: ARGV[2],
      count: 1
    )

    res = Primes::Alg::mod(cli.alg_str)::Rust.new(
      limit: cli.limit,
      count: cli.count
    ).run

    cli.full_res(lang: 'rust', result: res)
  end

  namespace :rust do
    desc "🦀=>  rake primes:rust:sieve_of_atkin {limit}  =>  " \
         "Find primes using the Sieve Of Atkin algorithm built in 🦀Rust"
    task :sieve_of_atkin do
      init_task(rust: true)

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
      init_task(rust: true)

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
