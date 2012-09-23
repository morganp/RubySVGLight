
module RubySVGLight
  VERSION = '0.1.0'
end

begin
 require 'ruby_svg_light/document'
rescue
  require_relative 'ruby_svg_light/document'
end
