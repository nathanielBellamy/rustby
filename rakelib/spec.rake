require_relative "../lib/rustby"
require "rutie"

namespace :spec do
  desc "Build Rust and Run Rspec"
  task :run do
    `cargo clean`

    p " => Cargo Test: <="
    pp `cargo test`
    `cargo build --release` # always build for release before running rspecr
    p " => Rspec: <="
    pp `rspec`
  end
end
