require 'spec_helper'

def style_contains( format )
  #This has been split over 2 lines to fix a bug in my syntax highlighter :(
  regex = %{style=\"(.*;)* ?#{format};(.*;)* ? \"}
  return /#{regex}/
end
    
describe RubySVGLight do
  
  #Hooks
  before( :each ) do
    @canvas = RubySVGLight::Document.new()
    # 10 Random characters for test string changes for each test
    @text = (0...10).map{ (('A'..'Z').to_a + ('a'..'z').to_a)[rand(52)] }.join
  end

  after( :each ) do
    #Verify that actual text was included regardless of options used
    @canvas.to_s.should include ">#{@text}\n       </text>"
  end

  



  #Tests
  it "Text, default font size" do
    @canvas.text( 0, 0, @text)

    @canvas.to_s.should include %{font-size="24px"} 
  end

  it "Text, set fontsize with local option" do
    @canvas.text( 0, 0, @text, {:font_size=>'100px'})

    @canvas.to_s.should include %{font-size="100px"}
  end

  it "Text, set fontsize with global option" do
    @canvas.options( {:font_size=>'100px'} )
    @canvas.text( 0, 0, @text)

    @canvas.to_s.should include %{font-size="100px"} 
  end





  # The 4 ways to vertically centre text
  it "Text, Vertical centre with :text_vertical_centre" do
    @canvas.text( 0, 0, @text, {:text_vertical_centre=>true})

    @canvas.to_s.should match style_contains("dominant-baseline: central")
  end

  it "Text, Vertical centre with :text_vertical_middle" do
    @canvas.text( 0, 0, @text, {:text_vertical_middle=>true})

    @canvas.to_s.should match style_contains("dominant-baseline: central")
  end

  it "Text, Vertical centre with :text_v_centre" do
    @canvas.text( 0, 0, @text, {:text_v_centre=>true})

    @canvas.to_s.should match style_contains("dominant-baseline: central")
  end

  it "Text, Vertical centre with :text_v_middle" do
    @canvas.text( 0, 0, @text, {:text_v_middle=>true})

    @canvas.to_s.should match style_contains("dominant-baseline: central")
  end





  # The 4 ways to horizontally centre text
  it "Text, Horizontal centre with :text_horizontal_centre" do
    @canvas.text( 0, 0, @text, {:text_horizontal_centre=>true})

    @canvas.to_s.should match style_contains("text-anchor: middle")
  end

  it "Text, Horizontal centre with :text_horizontal_middle" do
    @canvas.text( 0, 0, @text, {:text_horizontal_middle=>true})

    @canvas.to_s.should match style_contains("text-anchor: middle")
  end
  it "Text, Horizontal centre with :text_h_centre" do
    @canvas.text( 0, 0, @text, {:text_h_centre=>true})

    @canvas.to_s.should match style_contains("text-anchor: middle")
  end

  it "Text, Horizontal centre with :text_h_middle" do
    @canvas.text( 0, 0, @text, {:text_h_middle=>true})

    @canvas.to_s.should match style_contains("text-anchor: middle")
  end





  #Vertical and Horizontal centre text
  it "Text, Horizintal and Vertical centre with :text_horizontal_centre and :text_vertical_centre" do
    @canvas.text( 0, 0, @text, {:text_horizontal_centre=>true,:text_vertical_centre=>true})

    @canvas.to_s.should match style_contains("dominant-baseline: central")
    @canvas.to_s.should match style_contains("text-anchor: middle")
  end

  it "Text, Horizintal and Vertical centre with :text_centre" do
    @canvas.text( 0, 0, @text, {:text_centre=>true})

    @canvas.to_s.should match style_contains("dominant-baseline: central")
    @canvas.to_s.should match style_contains("text-anchor: middle")
  end


end


