require 'spec_helper'

describe Markup::Processor do
  describe "registration" do
    before do
      @processor_1 = mock("processor_1")
      @processor_2 = mock("processor_2")
      @processor_3 = mock("processor_3")

      described_class.register(:foo, :bar, @processor_1)
      described_class.register(:foo, :baz, @processor_2)
      described_class.register(:bar, :foo, @processor_3)
    end

    it "maps source and target formats to the correct processor" do
      described_class.for(:foo, :bar).should == @processor_1
      described_class.for(:foo, :baz).should == @processor_2
      described_class.for(:bar, :foo).should == @processor_3
    end

    it "raises UnsupportedTranslationError for unsupported translations" do
      lambda { described_class.for(:bar, :baz) }.should raise_error(Markup::UnsupportedTranslationError)
      lambda { described_class.for(:baz, :foo) }.should raise_error(Markup::UnsupportedTranslationError)
    end
  end
end
