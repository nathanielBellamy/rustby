# frozen_string_literal: true

RSpec.describe Primes::Alg::Naive::Base do
  let(:limit) { 10_000 }
  let(:count) { 5 }

  subject(:base) do
    described_class.new(**args)
  end

  describe "initialize" do
    context "when called by the Ruby child class" do
      it "returns an instance of Ruby class" do
        res = Primes::Alg::Naive::Ruby.new(limit: 2, count: 1)

        expect(res.class).to eq(Primes::Alg::Naive::Ruby)
        expect(res.lang).to eq("ruby")
      end
    end

    context "when called by the Rust child class" do
      it "returns an instance of Rust class" do
        res = Primes::Alg::Naive::Rust.new(limit: 2, count: 1)

        expect(res.class).to eq(Primes::Alg::Naive::Rust)
        expect(res.lang).to eq("rust")
      end
    end
  end
end
