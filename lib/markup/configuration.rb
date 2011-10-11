module Markup
  # Instances of this class hold configuration for the library. This is not a
  # singleton class -- multiple instances can be maintained and used as needed.
  class Configuration
    # Default format from which to translate the source.
    #
    # Default::          +:plain_text+
    # Possible Values::  +:plain_text+, +:html+
    attr_accessor :from

    # Default format to which to translate the source.
    #
    # Default::          +:html+
    # Possible Values::  +:plain_text+, +:html+
    attr_accessor :to

    # Default string to prepend to the name of the source field to come up
    # with the name of the target field. This can be used in conjunction with
    # the +:suffix+ option, but is disregarded if the +:target+ option is used.
    # Use +false+ to disable.
    #
    # Default::          +false+
    # Possible Values::  <tt>"_rendered"</tt>, <tt>"_html"</tt>, +false+
    attr_accessor :prefix

    # Default string to append to the name of the source field to come up with
    # the name of the target field. This can be used in conjunction with the
    # +:prefix+ option, but is disregarded if the +:target+ option is used.
    # Use +false+ to disable.
    #
    # Default::          <tt>"_rendered"</tt>
    # Possible Values::  <tt>"_rendered"</tt>, <tt>"_html"</tt>, +false+
    attr_accessor :suffix

    # Instantiate a record, also setting attributes to their default values. A
    # block may also be passed to further manipulate the record after default
    # values have been set.
    #
    #   Markup::Configuration.new
    #   
    #   Markup::Configuration.new do |config|
    #     config.from :markdown
    #   end
    #
    # ==== Default Values:
    #
    # *:from*:: +:plain_text+
    # *:to*:: +:html+
    # *:prefix*:: +false+
    # *:suffix*:: <tt>"_rendered"</tt>
    def initialize(&block)
      @from   = :plain_text
      @to     = :html
      @prefix = false
      @suffix = '_rendered'

      if block_given?
        yield self
      end
    end

    # Replicate the current configuration object and merge specified options.
    #
    #   configuration = Markup::Configuration.new
    #   configuration + {:from => :markdown}
    #   configuration + nil
    def +(obj)
      if obj.nil?
        self.class.new
      elsif obj.is_a?(Hash)
        self.class.new do |config|
          config.from = obj[:from]
          config.to = obj[:to]
          config.prefix = obj[:prefix]
          config.suffix = obj[:suffix]
        end
      else
        raise Markup::ArgumentError
      end
    end
  end
end
