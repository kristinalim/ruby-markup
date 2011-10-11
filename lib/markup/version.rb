module Markup
  # This module contains version information about the library.
  module Version
    require 'scanf'

    version_segments = File.read(File.dirname(__FILE__) + '/../../VERSION').scanf('%d.%d.%d')

    # This is the major version parsed from the VERSION file.
    MAJOR = version_segments[0]

    # This is the minor version parsed from the VERSION file.
    MINOR = version_segments[1]

    # This is the patch version parsed from the VERSION file.
    PATCH = version_segments[2]

    # This is the complete presentation of the version, formatted as a
    # concatentation of the major, minor, and patch versions parsed from the
    # VERSION file separated by dots. Example: <tt>1.0.2</tt>
    FULL = [MAJOR, MINOR, PATCH].join('.')
  end
end
