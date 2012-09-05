describe "CGRect" do
  before do
    @rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
  end

  it ".x, etc work" do
    [@rect.x, @rect.y, @rect.width, @rect.height].should == [10, 100, 50, 20]
  end

  it "chaining works" do
    rect = @rect.below(10).width(100).height(10)
    [rect.x, rect.y, rect.width, rect.height].should == [10, 130, 100, 10]

    [@rect.right(20).x, @rect.left(20).x, @rect.up(20).y, @rect.down(20).y].should == [30, -10, 80, 120]
  end

  it ".beside works" do
    rect = @rect.beside(10)
    [rect.x, rect.y, rect.width, rect.height].should == [70, 100, 50, 20]
  end

  it ".below works" do
    @rect.below(10).y.should == 130
  end

  it "layout works" do
    rect2 = CGRect.new [50, 50], [100, 100]
    rect3 = CGRect.new [100, 200], [20, 20]

    no_margins = CGRect.layout(@rect, above: rect2, right_of: rect3)
    [no_margins.x, no_margins.y, no_margins.width, no_margins.height].should == [120, 30, 50, 20]

    margins = CGRect.layout(@rect, above: rect2, right_of: rect3, margins: [0, 0, 10, 15])
    [margins.x, margins.y, margins.width, margins.height].should == [135, 20, 50, 20]
  end
end