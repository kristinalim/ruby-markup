module Markup
  module Processor
    # Base class for all processors.
    class Base
      def self.translate(source_text, configuration)
        source_text
      end
    end
  end
end
