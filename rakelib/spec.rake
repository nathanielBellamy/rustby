# frozen_string_literal: true

require_relative "../lib/rustby"
require "rutie"

namespace :spec do
  desc "Build Rust and Run Rspec"
  task :run do
    puts "\n  => Cargo Test: <= \n "
    `cargo clean`
    puts `cargo test`
    `cargo build --release` # always build for release before running rspecr
    puts "\n => Rspec: <= \n "
    puts `rspec`
  end
end
