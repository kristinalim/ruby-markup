require 'spec_helper'

describe Markup do
  describe "global configuration" do
    it "is initialized to default configuration" do
      described_class.configuration.should be_instance_of(described_class::Configuration)
    end

    it "accesses the record as the argument if a block is given" do
      configuration = described_class.configuration
      described_class.configuration do |config|
        config.should equal(configuration)
      end
    end

    it "retains the configuration object across calls" do
      configuration = described_class.configuration

      described_class.configuration { |config| }
      described_class.configuration.should equal(configuration)
    end
  end

  describe "translation" do
    before do
      @global_configuration = described_class.configuration do |config|
        config.from = mock("global_configuration_from")
        config.to = mock("global_configuration_to")
        config.prefix = mock("global_configuration_prefix")
        config.suffix = mock("global_configuration_suffix")
      end

      @configuration = described_class::Configuration.new do |config|
        config.from = mock("configuration_from")
        config.to = mock("configuration_to")
        config.prefix = mock("configuration_prefix")
        config.suffix = mock("configuration_suffix")
      end

      @options = {:from => :markdown, :to => :html}
    end

    it "raises error with more than two customizations" do
      lambda { described_class.translate("foo", @configuration, @options, @options) }.should raise_error(Markup::ArgumentError)
    end

    it "raises error if customization is neither Hash nor configuration object" do
      lambda { described_class.translate("foo", :bar) }.should raise_error(Markup::ArgumentError)
    end

    it "raises error if first of two customizations is not configuration object" do
      lambda { described_class.translate("foo", :bar, @options) }.should raise_error(Markup::ArgumentError)
    end

    it "raises error if second of two customizations is not Hash" do
      lambda { described_class.translate("foo", @configuration, :bar) }.should raise_error(Markup::ArgumentError)
    end

    describe "when determining effective configuration" do
      before do
        @custom_from = mock("custom_from")
        @custom_to = mock("custom_to")
      end

      it "uses global configuration by default" do
        described_class::Processor.stub(:for).with(@global_configuration.from, @global_configuration.to) { TestMarkupProcessor }
        TestMarkupProcessor.should_receive(:translate).with("foo", @global_configuration)
        described_class.translate("foo")
      end

      it "processes custom configuration if specified" do
        described_class::Processor.stub(:for).with(@configuration.from, @configuration.to) { TestMarkupProcessor }
        TestMarkupProcessor.should_receive(:translate).with("foo", @configuration)
        described_class.translate("foo", @configuration)
      end

      describe "when options are specified" do
        it "processes from format option" do
          described_class::Processor.stub(:for).with(@custom_from, @global_configuration.to) { TestMarkupProcessor }
          configuration_with_from = mock("configuration_with_from", :from => @custom_from, :to => @global_configuration.to)
          @global_configuration.stub(:+).with(:from => @custom_from) { configuration_with_from }

          TestMarkupProcessor.should_receive(:translate).with("foo", configuration_with_from)
          described_class.translate("foo", @global_configuration, :from => @custom_from)
        end

        it "processes to format option" do
          described_class::Processor.stub(:for).with(@global_configuration.from, @custom_to) { TestMarkupProcessor }
          configuration_with_to = mock("configuration_with_to", :from => @global_configuration.from, :to => @custom_to)
          @global_configuration.stub(:+).with(:to => @custom_to) { configuration_with_to }

          TestMarkupProcessor.should_receive(:translate).with("foo", configuration_with_to)
          described_class.translate("foo", @global_configuration, :to => @custom_to)
        end
      end

      describe "when custom configuration and options are specified" do
        it "processes from format option" do
          described_class::Processor.stub(:for).with(@custom_from, @configuration.to) { TestMarkupProcessor }
          configuration_with_from = mock("configuration_with_from", :from => @custom_from, :to => @configuration.to)
          @configuration.stub(:+).with(:from => @custom_from) { configuration_with_from }

          TestMarkupProcessor.should_receive(:translate).with("foo", configuration_with_from)
          described_class.translate("foo", @configuration, :from => @custom_from)
        end

        it "processes to format option" do
          described_class::Processor.stub(:for).with(@configuration.from, @custom_to) { TestMarkupProcessor }
          configuration_with_to = mock("configuration_with_to", :from => @configuration.from, :to => @custom_to)
          @configuration.stub(:+).with(:to => @custom_to) { configuration_with_to }

          TestMarkupProcessor.should_receive(:translate).with("foo", configuration_with_to)
          described_class.translate("foo", @configuration, :to => @custom_to)
        end
      end
    end

    it "delegates translation to registered processor with effective configuration" do
      described_class::Processor.stub(:for) { TestMarkupProcessor }
      TestMarkupProcessor.stub(:translate).with("foo", @global_configuration) { "bar" }
      described_class.translate("foo").should == "bar"
    end
  end
end
