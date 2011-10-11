# This class defines rspec shared examples for markup processors.
module MarkupProcessors
  shared_examples_for "markup processor" do
    it "is a subclass of Markup::Processor::Base" do
      described_class.ancestors.include?(Markup::Processor::Base)
    end

    it "manages translations for the processor" do
      described_class.respond_to?(:translate)
    end

    it "translates correctly" do
      example_translations.each do |from, from_translations|
        from_translations.each do |to, translations|
          translations.each do |source, target|
            configuration = Markup::Configuration.new do |config|
              config.from = from
              config.to = to
            end
            Markup.translate(source, configuration).should == target
          end
        end
      end
    end
  end
end
