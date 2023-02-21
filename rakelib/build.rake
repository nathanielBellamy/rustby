# frozen_string_literal: true

require_relative "../lib/rustby"
require "rutie"

namespace :build do
  desc "Bundle Gems + Build Rust"
  task :main do
    `bundle install`
    `cargo build --release`
  end

  desc "build rust"
  task :rust do
    `cargo build --release`
  end
end
