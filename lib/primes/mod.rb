# frozen_string_literal: true

require_relative "alg/mod"

module Primes
  class Error < StandardError; end

  # algorithm engine base
  class Base
    attr_reader :alg_str, :limit, :count

    def initialize(alg_str: "", limit: 2, count: 5)
      @alg_str = alg_str
      @limit = limit
      @count = count
    end

    def alg
      case alg_str
      when "sieve_of_atkin", "soa", "s"
        @alg ||= Primes::Alg::SieveOfAtkin
      when "naive", "n"
        @alg ||= Primes::Alg::Naive
      else
        raise Primes::Error,
              UserIO::Cli.alg_not_found
      end
    end
  end
end
