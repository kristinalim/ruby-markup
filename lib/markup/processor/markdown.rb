module Markup
  module Processor
    # Handles translations from Markdown to HTML.
    class Markdown < Base
      require 'bluecloth'

      def self.translate(source_text, configuration) # :nodoc:
        if configuration.from == :markdown
          case configuration.to
          when :html:
            ::BlueCloth.new(source_text).to_html
          else
            raise 'Translation is not supported by processor.'
          end
        else
          raise 'Translation is not supported by processor.'
        end
      end
    end
  end
end
