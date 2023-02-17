# frozen_string_literal: true

RSpec.describe Primes::Alg::SieveOfAtkin::Ruby do
  let(:limit) { 10_000 }
  let(:count) { 5 }

  subject(:soa_ruby) { described_class.new(limit, count) }

  describe "run" do
    it "runs algorithm {count} times" do # ruby handles looping
      expect(soa_ruby).to receive(:sieve_of_atkin).exactly(5).times
      soa_ruby.run
    end
  end

  describe "sieve_of_atkin" do
    let(:count) { 1 } # only need to compute it once

    it "finds all primes up to 10,000" do
      expect(soa_ruby.sieve_of_atkin).to match_array PRIMES_TO_10K
    end
  end
end
