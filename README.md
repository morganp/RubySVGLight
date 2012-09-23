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

From version 0.1.0 blocks can be used:

    # Implicit Block
    RubySVGLight::Document.generate("implicit.svg") do
      circle(10,20,30)
    end

    # Explicit Block
    RubySVGLight::Document.generate("explicit.svg") do |svg|
      svg.circle(10,20,30)
    end

Second Example, From the Examples directory

    require 'ruby_svg_light'
    canvas = RubySVGLight::Document.new
    canvas.circle(40,40,20)
    canvas.rectangle(80,20,40,40)
    canvas.line(20,80,100,0)
    canvas.line(20,105,100,0)
    
    #Set Global Options
    options = {:font_size=>'12px'}
    canvas.options(options)
    canvas.text(20,100, 'HelloWorld!')
    
    #Set Local Options
    canvas.text(20,130, 'HelloWorld!', {:font_size=>'18px'})
    
    canvas.to_file('shapes.svg')

Text placment options

    canvas.text(0,20, 'HelloWorld!', {:text_horizontal_centre=>true})
    canvas.text(0,0,  'HelloWorld!', {:text_vertical_centre=>true})
    # Centre Horizontally and Vertically
    canvas.text(0,40, 'HelloWorld!', {:text_centre=>true})
    


TODO
----

Add support for path
