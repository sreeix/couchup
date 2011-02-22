# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "couchup/version"

Gem::Specification.new do |s|
  s.name        = "couchup"
  s.version     = Couchup::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["V Sreekanth"]
  s.email       = ["sreeix@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Command line inteface to a couchdb deployment.}
  s.description = %q{Command line inteface to a couchdb deployment.}

  s.rubyforge_project = "couchup"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.default_executable = "ey"

  s.require_paths = ["lib"]
  
  
  s.add_dependency('couchrest')
  s.add_dependency('yajl-ruby')
  s.add_dependency('json')
  s.add_dependency('mime-types')
  s.add_dependency('rest-client')
  
  s.add_development_dependency('rspec', '1.3.0')
  s.add_development_dependency('rake')
  s.add_development_dependency('bundler')
end
