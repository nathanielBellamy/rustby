# frozen_string_literal: true

RSpec.describe Primes::Alg::Naive do
  let(:limit) { 15_000 } # a little further to prove correct dynamic computation
                         # but don't want to slow down specs
  let(:count) { 1 }
  let(:soa_ruby) { Primes::Alg::Naive::Ruby.new(limit, count) }
  let(:soa_rust) { Primes::Alg::Naive::Rust.new(limit, count) }

  describe "naive" do
    it "finds the same primes whether using ruby or rust" do
      ruby_res = soa_ruby.run
      rust_res = soa_rust.run

      expect(ruby_res.length).to eq(1754)
      expect(ruby_res.to_a).to match_array rust_res
    end
  end
end
