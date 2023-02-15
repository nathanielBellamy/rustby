require_relative "../lib/rustby"
require "rutie"

namespace :primes do
  desc "Welcome to Rustby!"
  # rake primes:main {limit} {algorithm} {count}
  task :main do
    suppress_input_as_tasks

    cli = UserIO::Cli.new(ARGV)
    Rustby.main(cli)
  end

  desc "Compare Ruby and Rust by Finding Primes Using the Sieve of Atkin Algorithm"
  # rake primes:sieve_of_atkin {limit} {count}
  task :sieve_of_atkin do
    suppress_input_as_tasks

    alg_str = "sieve_of_atkin"
    limit = ARGV[1]
    count = ARGV[2]
    cli = UserIO::Cli.new([limit, alg_str, count])
    Rustby.main(cli)
  end

  desc "Compare Ruby and Rust by Finding Primes Using a Naive Algorithm"
  # rake primes:naive {limit} {count}
  task :naive do
    suppress_input_as_tasks

    alg_str = "naive"
    limit = ARGV[1]
    count = ARGV[2]
    cli = UserIO::Cli.new([limit, alg_str, count])
    Rustby.main(cli)
  end

  def suppress_input_as_tasks
    # prevents errors of the form:
    #   rake aborted!
    #   Don't know how to build task {cli_input} (See the list of available tasks with `rake --tasks`)
    ARGV.each { |a| task a.to_sym {} }
  end
end
