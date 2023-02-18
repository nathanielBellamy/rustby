RSpec.describe Services::Benchmarker do
  let(:mod) { Primes::Alg::SieveOfAtkin }
  let(:limit) { 10_000 }
  let(:count) { 2 }
  let(:args) { {alg_str: "sieve_of_atkin", limit: limit, count: count} }

  subject(:benchmarker) do
    described_class.new(
      mod: mod,
      func: "public_run",
      args: args
    )
  end

  describe "run" do
    it "calls Benchmark.bmbm one time to run comparison" do
      expect(Benchmark).to receive(:bmbm)
        .exactly(1).time
        .and_call_original
      benchmarker.run
    end

    context "when calling the RUST class" do
      it "it calls exactly once per phase of bmbm" do
        # verify that rust handles looping
        expect(RUST).to receive(:sieve_of_atkin)
                          .with(limit, count)
                          .exactly(2).times # rehersal and main phase of .bmbm
                          .and_call_original
        benchmarker.run
      end
    end
  end
end
