# frozen_string_literal: true

require_relative "../lib/rustby"
require "rutie"

desc "Welcome to 🦀rustby🐝."
task :main do
  init_task
  cli = Cli::Base.new
  cli.tour
  cli.outro
end
