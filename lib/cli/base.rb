# frozen_string_literal: true

require "tty-spinner"

module Cli
  # provide cli functionality
  class Base
    def welcome
      empty_lines
      puts <<-HEREDOC
                          === Welcome to 🦀rustby🐝 ===
                  === Build in #{ruby_marker}. Optimize in #{rust_marker}. ===
                   === thx. to github/danielpclark/rutie ===
      HEREDOC
      empty_lines
    end

    def outro
      empty_lines
      puts <<-HEREDOC
                      🐝💎🦀 Thanks for stopping by! 🦀💎🐝
      HEREDOC
      empty_lines
    end

    def pause(duration, effect: false)
      spinner = TTY::Spinner.new(format: :bouncing_ball)
      puts " *** " if effect
      spinner.auto_spin
      sleep duration
      spinner.success("")
    end

    def empty_line
      puts "\n"
    end

    def empty_lines
      empty_line
      empty_line
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def tour
      welcome
      empty_lines
      pause(5)
      puts <<-HEREDOC
          🦀rustby🐝
            => embed Rust optimizations into a Ruby codebase
            => default to Ruby if Rust encounters an issue
      HEREDOC
      empty_lines
      pause(7)
      puts <<-HEREDOC
          🦀rustby🐝 provides two basic service classes to establish this pattern:
      HEREDOC
      empty_lines
      pause(7)
      puts <<-HEREDOC
              => Benchmarker
                => pass in a computation module with both a Ruby and a Rust class
                      MyComputation::Ruby, MyComputation::Rust
                => demonstrate performance in Rust compared to Ruby
                => a thin wrapper around Ruby's Benchmark class
      HEREDOC
      empty_line
      puts <<-HEREDOC
                        "...and..."
      HEREDOC
      empty_line
      pause(7)
      puts <<-HEREDOC
              => Fallbacker
                => pass in a computation module with both a Ruby and a Rust class
                      MyComputation::Ruby, MyComputation::Rust
                => first call #{rust_marker}
                      MyComputation::Rust.new(args).run
                => if success
                      return results
                => if error call #{ruby_marker}
                      MyComputation::Ruby.new(args).run
      HEREDOC
      empty_lines
      pause(7)
      puts <<-HEREDOC
            You can see these classes in action by running:
                => rake primes:demo:benchmark {limit} {count}
                => rake primes:demo:fallback {limit} {count}

            You can find primes using either Ruby or Rust by running:
                => rake primes:ruby {limit} {alg_str}
                => rake primes:rust {limit} {alg_str}

            To see a full list of tasks available, use
                rake --tasks
      HEREDOC
      pause(7)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def ruby_marker
      "💎RUBY"
    end

    def rust_marker
      "🦀RUST"
    end
  end
end
