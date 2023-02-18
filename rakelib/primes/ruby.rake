require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  namespace :ruby do
    desc "Find primes using the SieveOfAtkin Algorithm Built in Rust " \
         "  =>  rake primes:ruby:sieve_of_atkin {limit}"
    task :sieve_of_atkin do
      suppress_input_as_tasks

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: 'sieve_of_atkin',
        count: 1
      )

      res = Primes::Alg::SieveOfAtkin::Ruby.new(
        limit: cli.limit,
        count: cli.count
      ).run

      cli.full_res(lang: 'ruby', result: res)
    end

    desc "Find primes using the Naive Algorithm Built in Rust " \
         "  =>  rake primes:ruby:naive {limit}"
    task :naive do
      suppress_input_as_tasks

      cli = Primes::Cli.new(
        limit: ARGV[1],
        alg_string: 'naive',
        count: 1
      )

      res = Primes::Alg::Naive::Ruby.new(
        limit: cli.limit,
        count: cli.count
      ).run

      cli.full_res(lang: 'ruby', result: res)
    end

  end
end
