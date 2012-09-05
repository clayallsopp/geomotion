# -*- encoding: utf-8 -*-
require File.expand_path('../lib/geomotion/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "geomotion"
  s.version     = Geomotion::VERSION
  s.authors     = ["Clay Allsopp"]
  s.email       = ["clay.allsopp@gmail.com"]
  s.homepage    = "https://github.com/clayallsopp/geomotion"
  s.summary     = "A RubyMotion Geometry Wrapper"
  s.description = "A RubyMotion Geometry Wrapper"

  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
end