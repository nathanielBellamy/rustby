# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new


# primes module
import "rakelib/primes/benchmark.rake"
import "rakelib/primes/rust.rake"
import "rakelib/primes/ruby.rake"

task default: %i[spec rubocop]

