# frozen_string_literal: true

RSpec.describe Rustby do
  it "has a version number" do
    expect(Rustby::VERSION).not_to be nil
  end

  context "when doing things" do
    let(:useful_helper_dbl) { instance_double(UsefulHelper) }
    before do
      allow(UsefulHelper).to receive(:new).and_return(useful_helper_dbl)
      allow(useful_helper_dbl).to receive(:provide_aid)
        .and_return("You have been helped by an imposter.")
    end

    it "does something useful" do
      count = 0
      message = ""
      expect do
        (0..3).each do |n|
          case n
          when 1, 2
            message = UsefulHelper.new.provide_aid
            expect(message).to eq("You have been helped by an imposter.")
          when 3
            message = UsefulHelper.provide_aid
          else
            message = "4! = 24"
          end
          count += 1
        end
      end.to change { count }.from(0).to(4)
      expect(useful_helper_dbl).to have_received(:provide_aid).exactly(2).times
      expect(message).to eq("You have been helped by the singleton.")
    end

    it "and also other useful things" do
      allow(UsefulHelper).to receive(:new).and_call_original
      expect(UsefulHelper.new.provide_aid).to eq("You have been helped.")
    end
  end

  class UsefulHelper
    def self.provide_aid
      "You have been helped by the singleton."
    end

    def provide_aid
      "You have been helped."
    end
  end
end
