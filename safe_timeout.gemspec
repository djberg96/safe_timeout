require_relative 'lib/safe_timeout/version'

Gem::Specification.new do |spec|
  spec.name          = "safe_timeout"
  spec.version       = SafeTimeout::VERSION
  spec.authors       = "David McCullars"
  spec.email         = "david.mccullars@gmail.com"
  spec.summary       = "A safer alternative to Ruby's Timeout that uses processes instead of threads."
  spec.description   = "A safer alternative to Ruby's Timeout that uses processes instead of threads."
  spec.homepage      = "https://github.com/david-mccullars/safe_timeout"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "sys-proctable", "~> 1.2"
end
