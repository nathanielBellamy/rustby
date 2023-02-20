require_relative "../../lib/rustby"
require "rutie"

namespace :primes do
  desc "💎🦀=>  rake primes:benchmark {limit} {count} =>  " \
       "Benchmark Ruby and Rust using all available algorithms. "
  task :benchmark do
    puts "\n\n Sieve of Atkin \n "
    Rake::Task['primes:benchmark:sieve_of_atkin'].invoke(ARGV)
    puts "\n Naive \n "
    Rake::Task['primes:benchmark:naive'].invoke(ARGV)
  end

  namespace :benchmark do
    desc "💎🦀=>  rake primes:benchmark:sieve_of_atkin {limit} {count}  =>  " \
         "Find Primes Using the Sieve of Atkin Algorithm"
    task :sieve_of_atkin do
      init_task(rust: true)

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

    desc "💎🦀=>  rake primes:benchmark:naive {limit} {count}  =>  " \
         "Find Primes Using a Naive Algorithm"
    task :naive do
      init_task(rust: true)

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
end
