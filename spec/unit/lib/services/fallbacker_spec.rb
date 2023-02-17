RSpec.describe Services::Fallbacker do
  let(:mod) { Primes::Alg::SieveOfAtkin }
  let(:func) { "public_run" }
  let(:limit) { 10_000 }
  let(:count) { 2 }
  let(:args) { {limit: limit, count: count} }

  subject(:fallbacker) do
    described_class.new(
      mod: mod,
      func: func,
      args: args
    )
  end

  describe "run" do
    it "calls the rust algorithm" do
      expect(RUST).to receive(:sieve_of_atkin).exactly(1).time.and_call_original
      fallbacker.run
    end

    context "when rust does not panic" do
      it "does not call the ruby class" do
        expect(mod::Ruby).to receive(:new).exactly(0).time.and_call_original
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
        expect(mod::Ruby).to receive(:new).exactly(1).time.and_call_original # ruby alg called

        res = fallbacker.run
        expect(res).to match_array PRIMES_TO_10K # results still computed
      end
    end
  end
end
