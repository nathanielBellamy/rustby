RSpec.describe Primes::Services::Benchmarker do
  let(:alg_str) { "sieve_of_atkin" }
  let(:limit) { 10000 }
  let(:count) { 5 }

  subject(:benchmarker) do
    described_class.new(
      alg_str: alg_str,
      limit: limit,
      count: count
    )
  end

  describe "alg" do
    context "whe alg_str is sieve_of_atkin" do
      it 'returns SieveOfAtkin module' do
        expect(benchmarker.alg).to eq(Primes::Alg::SieveOfAtkin)
      end
    end

    context "when alg_str is soa" do
      let(:alg_str) { "soa" }

      it 'returns SieveOfAtkin module' do
        expect(benchmarker.alg).to eq(Primes::Alg::SieveOfAtkin)
      end
    end

    context "when alg_str is s" do
      let(:alg_str) { "s" }

      it 'returns SieveOfAtkin module' do
        expect(benchmarker.alg).to eq(Primes::Alg::SieveOfAtkin)
      end
    end

    context "when alg_str is naive" do
      let(:alg_str) { "naive" }

      it 'returns Naive module' do
        expect(benchmarker.alg).to eq(Primes::Alg::Naive)
      end
    end

    context "when alg_str is n" do
      let(:alg_str) { "n" }

      it 'returns Naive module' do
        expect(benchmarker.alg).to eq(Primes::Alg::Naive)
      end
    end

    context "when alg_str is not recognized" do
      let(:alg_str) { "unkown_string" }

      before do
        allow(UserIO::Cli).to receive(:alg_not_found).and_return("TEST PRIMES::ERROR")
      end

      it 'raises a PrimesError and calls UserIO::Cli.alg_not_found' do
        expect { benchmarker.alg }.to raise_error(
          Primes::Error,
          "TEST PRIMES::ERROR"
        )
      end
    end

    describe "run" do
      it "calls Benchmark.bmbm one time to run comparison" do
        expect(Benchmark).to receive(:bmbm)
          .exactly(1).time
          .and_call_original
        benchmarker.run
      end

      it "calls the UserIO::Cli class to handle output" do
        expect(UserIO::Cli).to receive(:ruby_marker).exactly(2).time.and_call_original
        expect(UserIO::Cli).to receive(:rust_marker).exactly(2).time.and_call_original
        expect(UserIO::Cli).to receive(:lang_res).exactly(2).times.and_call_original
        benchmarker.run
      end

      context "when calling the RUST class" do
        context "when alg_str is sieve_of_atkin" do
          let(:alg_str) { "sieve_of_atkin" }

          it "it calls sieve_of_atkin exactly once per test" do
            expect(RUST).to receive(:sieve_of_atkin)
                              .with(limit, count)
                              .exactly(2).times # rehersal and main phase of .bmbm
                              .and_call_original
            benchmarker.run
          end
        end

        context "when alg_str is sieve_of_atkin" do
          let(:alg_str) { "naive" }

          it "it calls naive exactly once per test" do
            expect(RUST).to receive(:naive)
                              .with(limit, count)
                              .exactly(2).times # rehersal and main phase of .bmbm
                              .and_call_original
            benchmarker.run
          end
        end
      end
    end
  end
end
