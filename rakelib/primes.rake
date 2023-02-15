require_relative "../lib/rustby"
require "rutie"

namespace :primes do
  desc "Welcome to Rustby!"
  # rake primes:main
  task :main do
    cli = UserIO::Cli.new(ARGV)
    Rustby.main(cli)
  end

  desc "Compare Ruby and Rust using the Sieve of Atkin"
  # rake primes:sieve_of_atkin {limit} {count}
  task :sieve_of_atkin do
    alg_str = "sieve_of_atkin"
    limit = ARGV[1]
    count = ARGV[2]
    cli = UserIO::Cli.new([limit, alg_str, count])
    Rustby.main(cli)
  end
end
