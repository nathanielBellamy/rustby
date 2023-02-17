# frozen_string_literal: true

RSpec.describe Primes::Alg::SieveOfAtkin::Rust do
  let(:limit) { 10_000 }
  let(:count) { 5 }

  let(:soa_rust) { described_class.new(limit, count) }

  describe "run" do
    it "calls rust RUST class exactly once" do # rust handles looping, ruby calls once
      expect(soa_rust).to receive(:run).exactly(1).time.and_call_original
      expect(RUST).to receive(:sieve_of_atkin).exactly(1).time.and_call_original

      soa_rust.run
    end

    context "when computing primes up to 10k" do
      let(:count) { 1 } # only need to compute it once

      it "finds the correct ones" do
        expect(soa_rust.run).to match_array PRIMES_TO_10K
      end
    end
  end
end
