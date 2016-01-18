# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kramdown-pages/version'

Gem::Specification.new do |gem|
  gem.name          = "kramdown-pages"
  gem.version       = Kramdown::Parser::PAGES_VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Michael lang"]
  gem.email         = ["mwlang@cybrains.net"]
  gem.description   = %q{Kramdown syntax for embedding Rails app served page links}
  gem.summary       = %q{Extend Kramdown syntax to generate a href tags for embedded pages}
  gem.homepage      = "https://github.com/mwlang/kramdown-pages"

  gem.add_dependency('kramdown', '~> 1.6.0')

  gem.add_development_dependency('yard', '~> 0.8.3')
  gem.add_development_dependency('bundler', '>= 1.0.0')
  gem.add_development_dependency('rspec', '~> 2.12.0')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
