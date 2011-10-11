require 'spec_helper'

describe Markup::Processor::Markdown do
  it_should_behave_like "markup processor"

  def example_translations
    {
        :markdown => {
            :html => {
                "foo\n===" => "<h1>foo</h1>"
            }
        }
    }
  end
end
