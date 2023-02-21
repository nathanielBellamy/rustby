# frozen_string_literal: true

require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  desc "💎=>  rake primes:ruby {limit} {alg_str}  =>  " \
       "Find primes using given algorithm built in 💎Ruby"
  task :ruby do
    init_task

    cli = Primes::Cli.new(
      limit: ARGV[1],
      alg_string: ARGV[2],
      count: 1
    )

    res = Primes::Alg.mod(cli.alg_str)::Ruby.new(
      limit: cli.limit,
      count: cli.count
    ).run

    cli.full_res(lang: "ruby", result: res)
  end

  namespace :ruby do
    desc "💎=>  rake primes:ruby:sieve_of_atkin {limit}  =>  " \
         "Find primes using the Sieve Of Atkin algorithm built in 💎Ruby"
    task :sieve_of_atkin do
      init_task

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: "sieve_of_atkin",
        count: 1
      )

      res = Primes::Alg::SieveOfAtkin::Ruby.new(
        limit: cli.limit,
        count: cli.count
      ).run

      cli.full_res(lang: "ruby", result: res)
    end

    desc "💎=>  rake primes:ruby:naive {limit}  =>  " \
         "find primes using the Naive algorithm built in 💎Ruby "
    task :naive do
      init_task

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: "naive",
        count: 1
      )

      res = Primes::Alg::Naive::Ruby.new(
        limit: cli.limit,
        count: cli.count
      ).run

      cli.full_res(lang: "ruby", result: res)
    end
  end
end
