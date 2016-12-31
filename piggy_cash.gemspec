# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'piggy_cash/version.rb'

Gem::Specification.new do |s|
  s.name        = 'piggy_cash'
  s.version     = PiggyCash::VERSION
  s.authors     = ["Christoph Pageler"]
  s.email       = 'christoph.pageler@me.com'
  s.summary     = "Piggy Cash helps you to organize income and outcome"
  s.description = "More Foo Bar"
  s.homepage    = 'http://christophpageler.de'
  s.license     = 'MIT'

  s.files       =  Dir["lib/**/*"] + %w( bin/piggycash README.md LICENSE )

  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'commander', '= 4.3.5'        # CLI parser
  s.add_dependency 'colored', '= 1.2'            # coloured terminal output
  s.add_dependency 'terminal-table', '= 1.4.5'   # actions documentation
  s.add_dependency 'ruby-progressbar', '= 1.7.5' # CLI progress bar
  s.add_dependency 'activerecord', '= 4.2.6'     # ActiveRecord
  s.add_dependency 'ruby-keychain', '= 0.3.2'    # Keychain Access

  # Development only
  s.add_development_dependency 'bundler', '= 1.11.2'
  s.add_development_dependency 'rake', '= 10.5.0'
end