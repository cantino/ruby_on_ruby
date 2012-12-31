# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ruby_on_ruby/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Cantino"]
  gem.email         = ["andrew@andrewcantino.com"]
  gem.description   = %q{An unholy amalgam of therubyracer's V8 engine and emcripted-ruby to allow truly sandboxed Ruby-in-Ruby execution.}
  gem.summary       = %q{A terrible idea.}
  gem.homepage      = "https://github.com/cantino/ruby_on_ruby"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ruby_on_ruby"
  gem.require_paths = ["lib"]
  gem.version       = RubyOnRuby::VERSION

  gem.add_dependency 'therubyracer'
end
