RubySVGLight
============

Install
-------

    gem install ruby_svg_light

Usage
-----

Create a new document (canvas) with RubySVGLight::Document.new then add the shapes you require to it. Finally use to_file to generate the file or call to_s to return the string of the SVG (useful for webapps).

Shapes available (x and y starting coordinates and cx and cy center of circle and ellipse)

    circle(cx, cy, radius)
    rectangle(x, y, width, height)
    line(x, y, width, height)
    text(x, y, 'text')
    ellipse(cx, cy, horizontal_radius, vertical_radius)

All can take a options hash as a final option. Supported options are:

    options[:stroke]       
    options[:stroke_width] 
    options[:fill]         
    options[:font_size]    

Global options can also be set by passing to new or options, as seen in second example.


Examples
--------

    require 'ruby_svg_light'
    a = RubySVGLight::Document.new()
    a.circle(20,10,10)
    a.to_file('test.svg')

Second Example, From the Examples directory

    require 'ruby_svg_light'
    canvas = RubySVGLight::Document.new
    canvas.circle(40,40,20)
    canvas.rectangle(80,20,40,40)
    canvas.line(20,80,100,0)
    canvas.line(20,105,100,0)
    
    options = {:font_size=>'12px'}
    canvas.options(options)
    canvas.text(20,100, 'HelloWorld!')
    
    canvas.text(20,130, 'HelloWorld!', {:font_size=>'18px'})
    
    canvas.to_file('shapes.svg')

TODO
----

Improve text placement options  
Add support for path
