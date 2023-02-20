require "tty-spinner"

module Cli
    # provide cli functionality
  class Base
    def welcome
      p "                      === Welcome to 🦀rustby🐝 == "
      p "              === Build in #{ruby_marker}. Optimize in #{rust_marker}. ==="
      p "                === thx. to github/danielpclark/rutie === "
    end

    def pause(duration, effect: false)
      spinner_1 = TTY::Spinner.new(format: :bouncing_ball)
      p " ====== " if effect
      spinner_1.auto_spin
      sleep duration
      spinner_1.success("")
    end

    def divider_with_space
      p empty_line
      p empty_line
      p divider
      p divider
      p empty_line
      p empty_line
    end

    def divider
      " ====================================================================="
    end

    def empty_line
      ""
    end

    def outro
      divider_with_space
      p "               🐝💎🦀 Thanks for stopping by! 🦀💎🐝         "
      divider_with_space
    end

  end
end
