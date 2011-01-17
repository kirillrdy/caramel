# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "caramel/version"

Gem::Specification.new do |s|
  s.name        = "caramel"
  s.version     = Caramel::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kirill Radzikhovskyy"]
  s.email       = ["kirillrdy@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/caramel"
  s.summary     = %q{Adds sweetness to Ruby}
  s.description = %q{Adds more sweetness to Ruby}

  s.rubyforge_project = "caramel"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
