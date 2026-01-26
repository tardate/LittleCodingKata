#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative '../common/document'

  # frozen_string_literal: true
  
  Gem::Specification.new do |spec|
    spec.name = "document"
    spec.version = "1.0.1"
    spec.authors = ["Russ Olsen"]
    spec.email = "russ@russolsen.com"
  
    spec.summary = "Document - Simple document class"
    spec.description = spec.summary
    spec.homepage = "https://www.russolsen.com"
  
    spec.metadata["homepage_uri"] = spec.homepage
  
    gemspec = File.basename(__FILE__)
    spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
      ls.readlines("\x0", chomp: true).reject do |f|
        (f == gemspec) ||
          f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
      end
    end
    
    spec.require_paths = ["lib"]
  end
