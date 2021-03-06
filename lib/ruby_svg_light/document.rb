
module RubySVGLight
  class Document
    attr_reader :body

    def self.generate(filename,options={},&block)
      pdf = new(options,&block)
      pdf.render_file(filename)
    end

    def initialize( options={},&block )
      @options                  = options.dup
      @options[:name]         ||= ''
      @options[:width]        ||= :auto
      @options[:height]       ||= :auto
      @options[:stroke]       ||= '#000000'
      @options[:stroke_width] ||= 1
      @options[:fill]         ||= 'white'
      @options[:font_size]    ||= '24px'

      @width  = 0
      @height = 0
      @body   = []

      # Handle implicit or explicit blocks when required.
      if block_given?
        if block.arity == 1
          yield self
        else
          instance_eval &block
        end
      end
    end


    #Add render_file method like prawn
    def render_file(filename)
      to_file(filename)
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



    ## Drawing methodds
    def circle(x=0, y=0, radius=10, opts={})
      local_options = calc_local_options(opts)
      text = %{<circle
      cx="#{x}" cy="#{y}"
      r="#{radius}"
      stroke="#{local_options[:stroke]}"
      stroke-width="#{local_options[:stroke_width]}"
      fill="#{local_options[:fill]}"/>
      }

      update_size(x+radius, y+radius)
      @body << text
    end

    def line(x,y,w,h, opts={})
      local_options = calc_local_options(opts)
      text = %{<line
       x1="#{x}" y1="#{y}"
       x2="#{x+w}" y2="#{y+h}"
       stroke="#{local_options[:stroke]}"
       stroke-width="#{local_options[:stroke_width]}"
       />
       }
      #path d="m #{x},#{y} l #{x+w},#{y+h}"

      update_size(x+w, y+h)
      @body << text
    end

    def rectangle(x,y,width,height, opts={})
      local_options = calc_local_options(opts)
      text = %{<rect
       x="#{x}"         y="#{y}"
       width="#{width}" height="#{height}"
       fill="#{local_options[:fill]}"
       stroke="#{local_options[:stroke]}"
       stroke-width="#{local_options[:stroke_width]}"
       />
       }
      update_size(x+width, y+height)
      @body << text
    end

    def ellipse(x,y,rx,ry, opts={})
      local_options = calc_local_options(opts)
      text = %{<ellipse
       cx="#{x}" cy="#{y}"
       rx="#{rx}" ry="#{ry}"
       fill="#{local_options[:fill]}"
       stroke="#{local_options[:stroke]}"
       stroke-width="#{local_options[:stroke_width]}"
        />
      }
      update_size(x+rx, y+ry)
      @body << text
    end

    def text(x,y, input_text, opts={})
      centre_text = "text-anchor:middle; dominant-baseline:central;"
      local_options = calc_local_options(opts)

      text_vertical_centre  =  local_options[:text_centre] ||
                               local_options[:text_vertical_middle] ||
                               local_options[:text_vertical_centre] ||
                               local_options[:text_v_middle] ||
                               local_options[:text_v_centre]

      text_horizontal_centre = local_options[:text_centre] ||
                               local_options[:text_horizontal_middle] ||
                               local_options[:text_horizontal_centre] ||
                               local_options[:text_h_middle] ||
                               local_options[:text_h_centre]


      style = ""
      style << "dominant-baseline: central; " if text_vertical_centre 

      style << "text-anchor: top; "    if local_options[:text_horizontal_top]
      style << "text-anchor: middle; " if text_horizontal_centre
      style << "text-anchor: bottom; " if local_options[:text_horizontal_bottom]


      #Stroke is outline
      #fill is normal font. ie for text fill gets stroke colour
      text = %{<text
       x="#{x}" y="#{y}" }
      
      text << %{
       style="#{style}" } unless style == ""
      
      text << %{
       font-size="#{local_options[:font_size]}"
       fill="#{local_options[:stroke]}"
       font-family="Sans"
       >#{input_text}
       </text>
}
       #Do not know height or width of text only the anchor
       update_size(x, y)
       @body << text
    end

    def options(opts={})
      opts.each_pair do |key,value|
        @options[key] = value
      end

      #return
      @options
    end


    def height
      if @options[:height] == :auto
        @height
      else
        @options[:height]
      end
    end

    def width
      if @options[:width] == :auto
        @width
      else
        @options[:width]
      end
    end


    def components_only_to_s
      text = ""
      @body.each do |section|
        text << section
      end

      #return
      text
    end

    # To string includes header and footers
    def to_s
      text = ""
      text << self.header
      @body.each do |section|
        text << section
      end
      text << self.footer

      #return
      text
    end


    # to_file includes header and footers for a complete svg file
    def to_file( filename )
      File.open(filename, 'w') do |f|
        f.puts self.header
        @body.each do |section|
          f.puts section
        end
        f.puts self.footer
      end
    end


    # Private method, for allowing overide options
    def calc_local_options(opts={})
      local_opts = @options.dup
      opts.each_pair do |key,value|
        local_opts[key] = value
      end

      #return
      local_opts
    end

    #Internal helper function for updating dimensions
    def update_size(x,y)
      @width  = x if x > @width
      @height = y if y > @height
    end

  end
end



if $0 == __FILE__
  filename = 'test.svg'

  a = RubySVGLight::Document.new()
  a.circle(20,10,10)
  a.to_file( filename )

  puts "Created #{filename}"
end
