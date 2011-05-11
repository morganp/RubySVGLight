require 'spec_helper'

def check_width_height(svg, width, height)
    svg.width.should    == width
    svg.height.should   == height
end

describe RubySVGLight do
  it "Check width calculations, objects from origin" do
    canvas = RubySVGLight::Document.new()
    check_width_height(canvas, 0, 0)

    canvas.rectangle(0,0,10,20)
    check_width_height(canvas, 10, 20)

    canvas.line(0,0, 30, 40)
    check_width_height(canvas, 30, 40)

    canvas.circle(0,0,100)
    check_width_height(canvas, 100, 100)

    canvas.ellipse(0, 0, 300, 400)
    check_width_height(canvas, 300, 400)
  end

  it "Smaller new component should not shrink size" do
    canvas = RubySVGLight::Document.new()
    canvas.circle(0,0,100)
    check_width_height(canvas, 100, 100)
    
    canvas.circle(0,0,50)
    check_width_height(canvas, 100, 100)

    canvas.line(0,0, 60, 40)
    check_width_height(canvas, 100, 100)

    canvas.rectangle(0,0,10,20)
    check_width_height(canvas, 100, 100)

    canvas.ellipse(0, 0, 10, 20)
    check_width_height(canvas, 100, 100)
  end

  it "Check width calculations, objects not on origin" do
    canvas = RubySVGLight::Document.new()
    check_width_height(canvas, 0, 0)

    canvas.rectangle(15,25,10,20)
    check_width_height(canvas, 25, 45)

    canvas.line(35,45, 30, 40)
    check_width_height(canvas, 65, 85)

    canvas.circle(10,15,100)
    check_width_height(canvas, 110, 115)

    canvas.ellipse(100, 200, 30, 50)
    check_width_height(canvas, 130, 250)
  end
end


