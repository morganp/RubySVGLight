
test = false #require 'ruby_svg_light'
if not test
  require '../lib/ruby_svg_light'
end

canvas = RubySVGLight::Document.new
canvas.circle(40,40,20)
canvas.rectangle(80,20,40,40)
canvas.line(20,80,100,0)
canvas.line(20,100,100,0)

canvas.to_file('shapes.svg')
