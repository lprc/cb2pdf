#encoding: utf-8

Gem::Specification.new do |s|
  s.name          = 'cb2pdf'
  s.version       = '0.0.1'
  s.date          = Time.now.strftime('%Y-%m-%d')
  s.platform      = Gem::Platform::RUBY
  s.summary       = "A comicbook to pdf converter"
  s.description   = "A comicbook to pdf converter. Provides a very small API as well as a command line tool. Uses 7zip as an external extraction tool. Uses prawn and fastimage for assembling the pdf files."
  s.authors       = ["lprc"]
  s.files         = Dir.glob("{doc,lib,test}/**/*") + ["bin/7z-v1700-x86.exe", __FILE__]
  s.executables  << "cb2pdf"
  s.require_paths = ['lib']
  s.homepage      = 'http://rubygems.org/gems/cb2pdf'
  s.license       = 'MIT'

  s.add_development_dependency 'minitest', '~> 5'
  s.add_runtime_dependency 'prawn', '~> 2'
  s.add_runtime_dependency 'fastimage', '~> 2'
end
