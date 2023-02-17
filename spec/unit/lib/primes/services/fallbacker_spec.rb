RSpec.describe Primes::Services::Fallbacker do
  let(:alg_str) { "sieve_of_atkin" }
  let(:limit) { 10000 }
  let(:count) { 5 }
  let(:alg) { fallbacker.alg }

  subject(:fallbacker) do
    described_class.new(
      alg_str: alg_str,
      limit: limit,
      count: count
    )
  end

  describe "run" do
    it "calls the rust algorithm" do
      expect(RUST).to receive(:sieve_of_atkin).exactly(1).time.and_call_original
      fallbacker.run
    end

    context "when rust does not panic" do
      it "does not call ruby" do
        expect(alg::Ruby).to receive(:new).exactly(0).time.and_call_original
        fallbacker.run
      end
    end

    context "when rust errors" do
      before do
        allow(RUST).to receive(:sieve_of_atkin).with(limit, count) do
          ["RUST_ERROR", "Error: OH NO!"]
        end
      end

      it "calls ruby and completes the computation" do
        expect(alg::Ruby).to receive(:new).exactly(1).time.and_call_original # ruby alg called

        res = fallbacker.run
        expect(res).to match_array PRIMES_TO_10K # results still computed
      end
    end
  end
end
