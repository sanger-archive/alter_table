# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alter_table/version"

Gem::Specification.new do |s|
  s.name        = "alter_table"
  s.version     = AlterTable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matthew Denner"]
  s.email       = ["md12@sanger.ac.uk"]
  s.homepage    = ""
  s.summary     = %q{Adds multi-alteration ALTER TABLE}
  s.description = %q{Allows you to perform multiple table alterations in Rails migrations}

  s.rubyforge_project = "alter_table"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '~> 2.3.11'

  s.add_development_dependency 'rspec', '~> 2.3.0'
end
