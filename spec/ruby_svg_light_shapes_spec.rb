require 'spec_helper'

def shape_contains( shape )
  #This has been split over 2 lines to fix a bug in my syntax highlighter :(
  regex = %{<svg[\\w\\W]*>[\\W]*<#{shape}[\\w\\W]*\/>[\\W]*<\/svg>}
  return /#{regex}/
end



describe RubySVGLight do

  #Hooks
  before( :each ) do
    @canvas = RubySVGLight::Document.new()
  end



  #Tests
  it "Draw a circle x=10, y=20, r=30" do
    @canvas.circle(10,20,30)

    @canvas.to_s.should match shape_contains( 'circle' )
    @canvas.to_s.should include %{cx="10"}
    @canvas.to_s.should include %{cy="20"}
    @canvas.to_s.should include %{r="30"}
  end
  


  it "Draw a rectangle x=10, y=20, width=30, height=40" do
    @canvas.rectangle(10,20,30,40)

    @canvas.to_s.should match shape_contains( 'rect' )
    @canvas.to_s.should include %{x="10"}
    @canvas.to_s.should include %{y="20"}
    @canvas.to_s.should include %{width="30"}
    @canvas.to_s.should include %{height="40"}
  end



  it "Draw a line x=10, y=20, width=30, height=40" do
    @canvas.line(10,20,30,40)

    #SVG lines are drawn specifying start and end coordinates. 
    #RubySVGLite uses start coordinates and height width to make it consistent with other shapes.
    @canvas.to_s.should match shape_contains( 'line' )
    @canvas.to_s.should include %{x1="10"}
    @canvas.to_s.should include %{y1="20"}
    @canvas.to_s.should include %{x2="#{10+30}"}
    @canvas.to_s.should include %{y2="#{20+40}"}
  end



  it "Draw an ellipse x=10, y=20, width=30, height=40" do
    @canvas.ellipse(10,20,30,40)

    @canvas.to_s.should match shape_contains( 'ellipse' )
    @canvas.to_s.should include %{cx="10"}
    @canvas.to_s.should include %{cy="20"}
    @canvas.to_s.should include %{rx="30"}
    @canvas.to_s.should include %{ry="40"}
  end

end


