
test = false #require 'ruby_svg_light'
if not test
  require '../lib/ruby_svg_light'
end

canvas = RubySVGLight::Document.new
canvas.circle(40,40,20)
canvas.rectangle(80,20,40,40)
canvas.line(20,80,100,0)
canvas.line(20,105,100,0)
canvas.ellipse(200, 200, 20, 30)

options = {:font_size=>'12px'}
canvas.options(options)
canvas.text(20,100, 'HelloWorld!')

canvas.text(20,130, 'HelloWorld!', {:font_size=>'18px'})

canvas.to_file('shapes.svg')
