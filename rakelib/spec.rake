require_relative "../lib/rustby"
require "rutie"

namespace :spec do
  desc "Build Rust and Run Rspec"
  task :run do
    `cargo test`
    `cargo clean`
    `cargo clippy`
    `cargo build --release`

    Rake::Task['build:rust'].invoke
    `rspec`
  end
end
