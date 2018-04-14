
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "po_driver_fmwk"
  spec.version       = '0.0.1'
  spec.authors       = ["Martin Waltman"]
  spec.email         = ["martin@mkwiseman.com"]

  spec.summary       = %q{Ruby wrapper framework for Selenium WebDriver using the Page Object Model.}
  spec.homepage      = "https://github.com/dubszy/RubyPODriverFramework"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://mkwiseman.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "selenium-webdriver", "~> 3.11.0"
  spec.add_development_dependency "test-unit", "~> 3.2.7"
end
