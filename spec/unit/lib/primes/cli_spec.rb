# frozen_string_literal: true

RSpec.describe Primes::Cli do
  let(:limit) { 10_000 }
  let(:alg_str) { "sieve_of_atkin" }
  let(:count) { 2 }
  let(:args) { {limit: limit, alg_str: alg_str, count: count} }

  subject(:cli) do
    described_class.new(args)
  end

  describe "initialize" do
    context "when parsing limit into an integer" do
      context "when arg impliments .to_i" do
        let(:limit) { "1234" }

        it "succeeds" do
          expect(cli.limit).to eq(1234)
        end
      end

      context "when .to_i evaluates to <2" do
        context "when limit nil" do
          let(:limit) { nil }

          it "defaults to 1_000" do
            limit = nil
            expect(limit.to_i).to eq(0)
            expect(cli.limit).to eq(1_000)
          end
        end

        context "when limit starts with non-numeric char" do
          let(:limit) { "f31fo39o" }

          it "defaults to 1_000" do
            expect(limit.to_i).to eq(0)
            expect(cli.limit).to eq(1_000)
          end
        end

        context "when limit is decimal"  do
          let(:limit) { "1.283409875" }

          it "defaults to 1_000" do
            expect(limit.to_i).to eq(1)
            expect(cli.limit).to eq(1_000)
          end
        end
      end
    end

    context "when parsing the count" do
      context "when arg is anything" do
        let(:alg_str) { "literally any string" }

        it "succeeds" do
          # cli validates type, code calling cli must validate input
          expect(cli.alg_str).to eq("literally any string")
        end
      end

      context "when no argument passed, it defaults to sieve_of_atkin" do
        let(:alg_str) { nil }

        it "defaults to sieve_of_atkin" do
          expect(cli.alg_str).to eq("sieve_of_atkin")
        end
      end
    end

    context "when parsing count" do
      context "when arg impliments .to_i" do
        let(:count) { "9876" }

        it "succeeds" do
          # cli validates type, code calling cli must validate input
          expect(cli.count).to eq(9876)
        end
      end

      context "when argument does not impliment .to_i" do
        let(:count) { "oh no!" }

        it "defaults to 1" do
          expect(cli.count).to eq(1)
        end
      end
    end
  end
end
