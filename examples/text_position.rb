
test = false #require 'ruby_svg_light'
if not test
  require '../lib/ruby_svg_light'
end

def drawbox_with_crosshairs(canvas, x, y, width, height)
  hheight  = height/2
  hwidth   = width/2
  pointer  = 20
  hpointer = pointer/2

  canvas.rectangle(x,y,width,height)
  canvas.line(x+hwidth-hpointer,y+hheight,pointer,0)
  canvas.line(x+hwidth,y+hheight-hpointer,0,pointer)
end

canvas = RubySVGLight::Document.new
width,height = 100,40
x,y = 20,20 
drawbox_with_crosshairs(canvas, x ,y, width, height)
canvas.text( x+(100/2), y+(40/2), 'HelloWorld', {:font_size=>'12px'})
# Demo of expected positioning
canvas.rectangle(x+width+20,y,width,height, {:fill=>'white'})
canvas.rectangle(x+width+20+(width/2),y,width/2,height/2, {:fill=>'green'})


x,y = 20,4*20 
drawbox_with_crosshairs(canvas, x ,y, 100, 40)
canvas.text( x+(100/2), y+(40/2), 'HelloWorld', {:font_size=>'12px',:text_horizontal_top=>true})
# Demo of expected positioning
canvas.rectangle(x+width+20,y,width,height, {:fill=>'white'})
canvas.rectangle(x+width+20+(width/2),y,width/2,height/2, {:fill=>'green'})


x,y = 20,7*20 
drawbox_with_crosshairs(canvas, x ,y, 100, 40)
canvas.text( x+(100/2), y+(40/2), 'HelloWorld', {:font_size=>'12px',:text_horizontal_middle=>true})
# Demo of expected positioning
canvas.rectangle(x+width+20,y,width,height, {:fill=>'white'})
canvas.rectangle(x+width+20+(width/4),y,width/2,height/2, {:fill=>'green'})


x,y = 20,10*20 
drawbox_with_crosshairs(canvas, x ,y, 100, 40)
canvas.text( x+(100/2), y+(40/2), 'HelloWorld', {:font_size=>'12px',:text_horizontal_bottom=>true})
# Demo of expected positioning
canvas.rectangle(x+width+20,y,width,height, {:fill=>'white'})
canvas.rectangle(x+width+20+(width/2),y,width/2,height/2, {:fill=>'green'})





x,y = 20,13*20 
drawbox_with_crosshairs(canvas, x ,y, 100, 40)
canvas.text( x+(100/2), y+(40/2), 'HelloWorld', {:font_size=>'12px',:text_vertical_middle=>true})
# Demo of expected positioning
canvas.rectangle(x+width+20,y,width,height, {:fill=>'white'})
canvas.rectangle(x+width+20+(width/2),y+(height/4),width/2,height/2, {:fill=>'green'})


x,y = 20,16*20 
drawbox_with_crosshairs(canvas, x ,y, 100, 40)
canvas.text( x+(100/2), y+(40/2), 'HelloWorld', {:font_size=>'12px',:text_horizontal_middle=>true, :text_vertical_middle=>true})
# Demo of expected positioning
canvas.rectangle(x+width+20,y,width,height, {:fill=>'white'})
canvas.rectangle(x+width+20+(width/4),y+(height/4),width/2,height/2, {:fill=>'green'})


canvas.to_file('text_position.svg')
