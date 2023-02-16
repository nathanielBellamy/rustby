# frozen_string_literal: true

RSpec.describe SieveOfAtkin do
  let(:limit) { 1_000_000 }
  let(:count) { 1 }

  let(:soa_ruby) { SieveOfAtkin::Ruby.new(limit, count) }
  let(:soa_rust) { SieveOfAtkin::Rust.new(limit, count) }

  describe "sieve_of_atkin" do
    it "finds the same primes whether using ruby or rust" do
      ruby_res = soa_ruby.run
      rust_res = soa_rust.run

      expect(ruby_res.length).to eq(78498)
      expect(ruby_res).to match_array rust_res
    end
  end
end
