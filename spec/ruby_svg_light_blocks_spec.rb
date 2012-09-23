require 'spec_helper'

def shape_contains( shape )
  #This has been split over 2 lines to fix a bug in my syntax highlighter :(
  regex = %{<svg[\\w\\W]*>[\\W]*<#{shape}[\\w\\W]*\/>[\\W]*<\/svg>}
  return /#{regex}/
end

def check_and_delete_circle_file( filename )
  
  ::File.open( filename, "rb"){ |f| @canvas_file = f.read }

  @canvas_file.to_s.should match shape_contains( 'circle' )
  @canvas_file.to_s.should include %{cx="10"}
  @canvas_file.to_s.should include %{cy="20"}
  @canvas_file.to_s.should include %{r="30"}

  @canvas_file = "" # Clear so no it is being checked correctly each time
  ::File.delete( filename )
end



describe RubySVGLight do

  #Tests
  it "Draw a circle x=10, y=20, r=30, using assignment and render_file" do
    @canvas = RubySVGLight::Document.new()
    @canvas.circle(10,20,30)
    @canvas.render_file('assignment.svg')

    check_and_delete_circle_file( 'assignment.svg' )
  end

  it "Draw a circle x=10, y=20, r=30, using assignment and to_file" do
    @canvas = RubySVGLight::Document.new()
    @canvas.circle(10,20,30)
    @canvas.render_file('assignment2.svg')

    check_and_delete_circle_file( 'assignment2.svg' )
  end
  
  it "Draw a circle x=10, y=20, r=30, using implicit block" do
    # Implicit Block
    RubySVGLight::Document.generate("implicit.svg") do
      circle(10,20,30)
    end
    check_and_delete_circle_file( 'implicit.svg' )
  end

  it "Draw a circle x=10, y=20, r=30, using explicit block" do
    # Explicit Block
    RubySVGLight::Document.generate("explicit.svg") do |svg|
      svg.circle(10,20,30)
    end
    check_and_delete_circle_file( 'explicit.svg' )
  end

end


