require 'rake/gempackagetask'

NAME = "ruby_svg_light"

Dir.chdir( './lib/')
require NAME
Dir.chdir( './../')

spec = Gem::Specification.new do |s|
  s.name         = NAME
  s.version      = RubyIt::VERSION
  s.platform     = Gem::Platform::RUBY
  s.summary      = ''
  s.homepage     = 'http://amaras-tech.co.uk/software/RubySVGLight'
  s.authors      = "Morgan Prior"
  s.email        = NAME + "_gem@amaras-tech.co.uk"
  s.description  = <<-eos
   
  eos
   s.files        =  ["bin/#{NAME}"]
   s.files        += Dir.glob("LICENSE.rtf")
   s.files        += Dir.glob("examples/*")
   s.files        += Dir.glob("lib/**/*")
   s.files        += Dir.glob("spec/*")
   s.bindir       = 'bin'

   s.executables  = [NAME]
   s.has_rdoc     = false

  end
  Rake::GemPackageTask.new(spec).define

