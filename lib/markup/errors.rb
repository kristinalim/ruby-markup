module Markup
  # This is the base class of all Markup error types.
  Error = Class.new(RuntimeError)

  # Invalid passed argument.
  ArgumentError = Class.new(Markup::Error)
  # Attempted translation for source and target formats with no registered
  # processor.
  UnsupportedTranslationError = Class.new(Markup::Error)
end
