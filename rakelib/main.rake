require_relative "../lib/rustby"
require "rutie"

desc "Welcome to 🦀rustby🐝."
task :main do
  init_task

  cli = Primes::Cli.new(
    limit: 5_432_10,
    alg_string: 'sieve_of_atkin',
    count: 10
  )


end
