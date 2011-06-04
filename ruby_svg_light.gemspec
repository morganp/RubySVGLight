
NAME = "ruby_svg_light"

Dir.chdir( './lib/')
puts require NAME
Dir.chdir( './../')

Gem::Specification.new do |s|
  s.name         = NAME
  s.version      = RubySVGLight::VERSION
  s.platform     = Gem::Platform::RUBY
  s.summary      = 'Basic Helper for creating SVG Files'
  s.homepage     = 'http://amaras-tech.co.uk/software/RubySVGLight'
  s.authors      = "Morgan Prior"
  s.email        = NAME + "_gem@amaras-tech.co.uk"
  s.description  = %{A basic library for building SVG files. Not all properties of SVG are supported}
  s.files        = [Dir.glob("LICENSE.rtf")]
  s.files        += Dir.glob("README.md")
  s.files        += Dir.glob("HISTORY.md")
  s.files        += Dir.glob("Rakefile")
  s.files        += Dir.glob("examples/*")
  s.files        += Dir.glob("lib/**/*")
  s.files        += Dir.glob("spec/*")
end

