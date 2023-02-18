# frozen_string_literal: true

module Primes
  # algorithm engine base
  module Alg
    # algorithm engine base
    class Base
      attr_reader :alg_str, :limit, :count

      def initialize(alg_str: "naive", limit: 2, count: 1)
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

      def self.public_run(alg_str: "naive", limit: 2, count: 1)
        base = self.new(alg_str: alg_str, limit: limit, count: count)
        base.run
      end
    end
  end
end
