require 'rubygems'

SPEC = Gem::Specification.new do |s|
  s.name              = 'RIMA'
  s.version           = '1.0.0'
  s.author            = 'Matt Mower'
  s.email             = 'self@mattmower.com'
  s.homepage          = 'http://rubyforge.org/projects/rubymatt/'
  s.rubyforge_project = 'rubymatt'
  s.platform          = Gem::Platform::RUBY
  s.summary           = 'A library for Regressive Imagery Analysis'
  s.files             = Dir.glob( "{bin,lib,rid}/**/*" )
  s.require_path      = "lib"
  s.autorequire       = 'rima'
  s.bindir            = 'bin'
  s.executables       << 'rima'
end