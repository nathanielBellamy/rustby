module SieveOfAtkin
  class Rust
    attr_reader :n, :k

    def initialize(n: 2, k: 2)
      @n = n
      @k = k
    end

    # find all primes <= n
    # => run it k times
    def run
      # TODO
      p "HELLO FROM RUST"
    end
  end
end