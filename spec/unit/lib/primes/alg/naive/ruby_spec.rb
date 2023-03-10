# frozen_string_literal: true

RSpec.describe Primes::Alg::Naive::Ruby do
  let(:args) { { limit: 10_000, count: 5 } }
  subject(:naive_ruby) { described_class.new(**args) }

  describe "run" do
    it "runs algorithm {count} times" do # ruby handles looping
      expect(naive_ruby).to receive(:naive).exactly(5).times
      naive_ruby.run
    end
  end

  describe "sieve_of_atkin" do
    let(:count) { 1 } # only need to compute it once

    it "finds all primes up to 10,000" do
      expect(naive_ruby.naive).to match_array PRIMES_TO_10K
    end
  end
end
