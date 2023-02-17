# frozen_string_literal: true

RSpec.describe Primes::Alg::Naive do
  # limit is chosen to be further than what is stored in PRIMES_TO_10K
  # to prove correct dynamic computation
  let(:args) { {limit: 15_000, count: 1} }
  let(:soa_ruby) { Primes::Alg::Naive::Ruby.new(**args) }
  let(:soa_rust) { Primes::Alg::Naive::Rust.new(**args) }

  describe "naive" do
    it "finds the same primes whether using ruby or rust" do
      ruby_res = soa_ruby.run
      rust_res = soa_rust.run

      expect(ruby_res.length).to eq(1754)
      expect(ruby_res.to_a).to match_array rust_res
    end
  end
end
