# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

# primes module
import "rakelib/primes/benchmark.rake"
import "rakelib/primes/demo.rake"
import "rakelib/primes/rust.rake"
import "rakelib/primes/ruby.rake"

task default: %i[spec rubocop]

def init_task(rust: false)
  suppress_input_as_tasks
  Rustby.init_rust if rust
end

def suppress_input_as_tasks
  # prevents errors of the form:
  #   rake aborted!
  #   Don't know how to build task {cli_input} (See the list of available tasks with `rake --tasks`)
  ARGV.each { |a| task(a.to_sym {}) }
end
