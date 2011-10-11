require 'markup/processor/base'
require 'markup/processor/markdown'

module Markup
  # This module handles registration of processors.
  module Processor
    # Mappings of source and target formats to the desired processors.
    @@registrations = {}

    # Map the source and target formats to the desired processor.
    #
    #   Markup::Processor.register(:markdown, :html, MarkdownToHtmlProcessor)
    def self.register(from, to, processor)
      @@registrations[from] ||= {}
      @@registrations[from][to] = processor

      processor
    end

    # Retrieve the processor class for the source and target formats indicated.
    #
    #   Markup::Processor.for(:markdown, :html) #=> MarkdownToHtmlProcessor
    def self.for(from, to)
      if @@registrations.has_key?(from) && @@registrations[from].has_key?(to)
        @@registrations[from][to]
      else
        raise UnsupportedTranslationError, "No registered processors for translation from #{from.inspect} to #{to.inspect}"
      end
    end
  end
end

Markup::Processor.register :markdown, :html, Markup::Processor::Markdown
