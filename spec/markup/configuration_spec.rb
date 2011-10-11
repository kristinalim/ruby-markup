require 'spec_helper'

describe Markup::Configuration do
  def essential_attributes
    [:from, :to, :prefix, :suffix]
  end

  describe "when initialized with no arguments" do
    it "succeeds" do
      lambda { described_class.new }.should_not raise_error
    end

    it "sets default values" do
      configuration = described_class.new
      essential_attributes.each do |attribute|
        configuration.instance_variable_defined?("@#{attribute}").should be_true
      end
    end
  end

  describe "when initialized with a block" do
    before do
      @config_from = mock('config_from')
      @config_to = mock('config_to')
      @config_prefix = mock('config_prefix')
      @config_suffix = mock('config_suffix')
    end

    it "succeeds" do
      lambda {
        described_class.new do |config|
          config.from = @config_from
          config.to = @config_to
          config.prefix = @config_prefix
          config.suffix = @config_suffix
        end
      }.should_not raise_error
    end

    it "is able to access the record as the block argument" do
      configuration = described_class.new do |config|
        config.from = @config_from
        config.to = @config_to
        config.prefix = @config_prefix
        config.suffix = @config_suffix
      end

      configuration.from.should == @config_from
      configuration.to.should == @config_to
      configuration.prefix.should == @config_prefix
      configuration.suffix.should == @config_suffix
    end

    it "sets attributes to the default values" do
      configuration = described_class.new { |config| }

      essential_attributes.each do |attribute|
        configuration.instance_variable_defined?("@#{attribute}").should be_true
      end
    end
  end

  describe "customization" do
    before do
      @customization = Markup::Configuration.new
    end

    it "allows merging of null" do
      result = @customization + nil
      result.should_not equal(@customization)
      essential_attributes.each do |attribute|
        result.send(attribute).should == result.send(attribute)
      end
    end

    it "allows merging of options hash" do
      result = @customization + {:from => "foo"}
      result.should_not equal(@customization)
      (essential_attributes - [:from]).each do |attribute|
        result.send(attribute).should == result.send(attribute)
      end
      result.from.should == result.from
    end

    it "raises error if argument is neither nil nor a Hash" do
      lambda { @customization + :bar }.should raise_error(Markup::ArgumentError)
    end
  end
end
