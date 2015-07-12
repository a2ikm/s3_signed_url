# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3_signed_url/version'

Gem::Specification.new do |spec|
  spec.name          = "s3_signed_url"
  spec.version       = S3SignedUrl::VERSION
  spec.authors       = ["Masato Ikeda"]
  spec.email         = ["masato.ikeda@gmail.com"]

  spec.summary       = %q{Upload file to AWS S3 and generate presigned URL optionally.}
  spec.description   = %q{Upload file to AWS S3 and generate presigned URL optionally.}
  spec.homepage      = "https://github.com/a2ikm/s3_signed_url"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk", "~> 2"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
