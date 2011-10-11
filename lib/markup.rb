require 'markup/errors'
require 'markup/version'
require 'markup/configuration'
require 'markup/processor'

# This gem provides a simple, centralized interface for translation of markup
# from one format to another. It comes with a bunch of processors, and handles
# requirement of optional dependencies as configured needed.
module Markup
  @@configuration = Configuration.new

  # Access global configuration.
  #
  #   # Returns configuration instance for global configuration
  #   Markup.configuration
  #   
  #   # Uses the Configuration instance
  #   Markup.configuration.from
  #   
  #   # Executes the passed block with the configuration instance for global
  #   # configuration as the argument
  #   Markup.configuration do |config|
  #     config.from :markdown
  #   end
  def self.configuration(&block)
    if block_given?
      yield @@configuration
    end

    @@configuration
  end

  # Translate source text using applicable configuration and passed options.
  # This delegates translation to the registered processor for the source and
  # target formats.
  #
  # You can specify a configuration object if you do not want to use global
  # default configuration. This can be useful if you are dealing with
  # different media (for example: web, email).
  #
  #   Markup.translate(source_text)
  #   Markup.translate(source_text, configuration)
  #   Markup.translate(source_text, :from => :markdown)
  #   Markup.translate(source_text, configuration, :from => :markdown)
  def self.translate(source, *args)
    options = {}
    configuration = nil
    if args.length == 0
    elsif args.length == 1
      if args[0].is_a?(Configuration)
        configuration = args[0]
      elsif args[0].is_a?(Hash)
        options = args[0]
      else
        raise ArgumentError
      end
    elsif args.length == 2
      configuration = args.shift
      options = args.shift
    else
      raise ArgumentError
    end

    raise ArgumentError unless configuration.nil? || configuration.is_a?(Configuration)
    raise ArgumentError unless options.is_a?(Hash)

    effective_configuration = (configuration || self.configuration)
    effective_configuration += options unless options.nil? || options.empty?
    processor = Processor.for(effective_configuration.from, effective_configuration.to)
    processor.translate(source, effective_configuration)
  end
end
