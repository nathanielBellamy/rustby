RSpec.describe Primes::Alg::Base do
  let(:alg_str) { "sieve_of_atkin" }
  let(:limit) { 10000 }
  let(:count) { 5 }
  let(:args) { {alg_str: alg_str, limit: limit, count: count} }

  subject(:base) do
    described_class.new(**args)
  end

  describe "alg" do
    context "whe alg_str is sieve_of_atkin" do
      it 'returns SieveOfAtkin module' do
        expect(base.alg).to eq(Primes::Alg::SieveOfAtkin)
      end
    end

    context "when alg_str is soa" do
      let(:alg_str) { "soa" }

      it 'returns SieveOfAtkin module' do
        expect(base.alg).to eq(Primes::Alg::SieveOfAtkin)
      end
    end

    context "when alg_str is s" do
      let(:alg_str) { "s" }

      it 'returns SieveOfAtkin module' do
        expect(base.alg).to eq(Primes::Alg::SieveOfAtkin)
      end
    end

    context "when alg_str is naive" do
      let(:alg_str) { "naive" }

      it 'returns Naive module' do
        expect(base.alg).to eq(Primes::Alg::Naive)
      end
    end

    context "when alg_str is n" do
      let(:alg_str) { "n" }

      it 'returns Naive module' do
        expect(base.alg).to eq(Primes::Alg::Naive)
      end
    end

    context "when alg_str is not recognized" do
      let(:alg_str) { "unkown_string" }

      before do
        allow(Primes::Cli).to receive(:alg_not_found).and_return("TEST PRIMES::ERROR")
      end

      it 'raises a PrimesError and calls Primes::Cli.alg_not_found' do
        expect { base.alg }.to raise_error(
          Primes::Error,
          "TEST PRIMES::ERROR"
        )
      end
    end
  end
end
