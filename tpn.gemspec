# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tpn/version"

Gem::Specification.new do |s|
  s.name        = "tpn"
  s.version     = Tpn::VERSION
  s.authors     = ["Jeffrey van Aswegen, Douglas Anderson"]
  s.email       = ["jeffmess@gmail.com, i.am.douglas.anderson@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A simple API to the TPN web service -- www.tpn.co.za}
  s.description = %q{A simple API to the TPN web service -- www.tpn.co.za}

  s.rubyforge_project = "tpn"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("savon", "~> 0.9.7")
end
