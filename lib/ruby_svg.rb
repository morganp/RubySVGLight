
class RubySVG
  attr_accessor :stroke, :fill, :height, :width, :name, :font_size
  attr_reader :body

  def initialize( options={} )
    @options            = options
    @options[:name]   ||= ''
    #@options[:width]  ||= 0
    #@options[:height] ||= 0
    @options[:stroke] ||= '#000000'
    @options[:stroke_width] ||= 1
    @options[:fill]   ||= 'white'
    @options[:font_size] ||= '24px'
    
    @width  = 0
    @height = 0
    @body   = []
  end

  def update_size(x,y)
    @width  = x if x > @width
    @height = y if y > @height
  end

  def header
    text = %{<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">

<svg 
 width="100%"
 height="100%"
 version="1.1" 
 xmlns="http://www.w3.org/2000/svg">
 }
  end

  def footer
    text = %{</svg>}
  end




  def circle(x=0, y=0, radius=10)
    text = %{<circle
      cx="#{x}" 
      cy="#{y}" 
      r="#{radius}" 
      stroke="#{@options[:stroke]}"
      stroke-width="#{@options[:stroke_width]}" 
      fill="#{@options[:fill]}"/>
      }

    update_size(x+radius, y+radius)
    #The call below should be in method missing
    @body << text
  end

  def line(x,y,w,h)
    text = %{<path
       style="fill:none;stroke:#{@options[:stroke]};stroke-width:#{@options[:stroke_width]};stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
       d="m #{x},#{y} l #{w},#{h}"
       />
       }

    update_size(x+w, y+h)
    @body << text
  end

  def rectangle(x,y,width,height)
    text = %{<rect
       style="fill:#{@options[:fill]};stroke:#{@options[:stroke]};stroke-width:#{@options[:stroke_width]};stroke-linecap:butt;stroke-linejoin:miter;"
       width="#{width}"
       height="#{height}"
       x="#{x}"
       y="#{y}" />
       }
    update_size(x+width, y+height)
    @body << text
  end

  def text(x,y, input_text, size=@options[:font_size])
   centre_text = "text-anchor:middle; dominant-baseline:central;"


   #Stroke is outline
   #fill is normal font. ie for text fill gets stroke colour
   text = %{<text
       xml:space="preserve"
       style="font-size:#{size};font-style:normal;font-weight:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#{@options[:stroke]};fill-opacity:1;stroke:none;font-family:Sans;#{centre_text}"
       <tspan
         x="#{x}"
         y="#{y}">#{input_text}</tspan></text>
}
   #Do not know height or width of text only the anchor 
    update_size(x, y)
    @body << text
  end

  def to_s
    text = ""  
    @body.each do |section|
      text << section
    end
    return text
  end

  def components_only_to_s
    text = ""  
    @body.each do |section|
      text << section
    end
    return text
  end

  def finalise
    #Maybe add the initial and closing things here so we are just noramlly dealing drawn components
    @body.insert(0,  header)
    @body.insert(-1, footer)

  end


  def to_file( filename )
    File.open(filename, 'w') do |f|
      f.puts self.header
      @body.each do |section|
        f.puts section
      end
      f.puts self.footer
    end
  end
end


if $0 == __FILE__
  a = RubySVG.new()
  a.circle(20,10,10)
  a.to_file('test.svg')
end
