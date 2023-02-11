# frozen_string_literal: true

require_relative "rustby/version"

module Rustby
  class Error < StandardError; end
  pp "Count me in!"

  sleep 2

  pp "And a..."

  sleep 0.5

  (5..8).each do |n|
    pp n
    sleep 0.5
  end

  pp "Go!"
end
