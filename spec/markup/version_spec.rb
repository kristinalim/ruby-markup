require 'spec_helper'

describe Markup::Version do
  it "parses major version" do
    Markup::Version::MAJOR.should_not be_nil
  end

  it "parses minor version" do
    Markup::Version::MINOR.should_not be_nil
  end

  it "parses patch version" do
    Markup::Version::MINOR.should_not be_nil
  end

  it "generates full version" do
    Markup::Version::FULL.should_not be_nil
  end
end
