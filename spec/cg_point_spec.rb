describe "CGPoint" do
  before do
    @point = CGPoint.make(x: 10, y: 20)
  end

  describe ".make" do
    it "should work with options" do
      CGPointEqualToPoint(@point, CGPointMake(10, 20)).should == true
    end

    it "should work with no options" do
      CGPointEqualToPoint(CGPoint.make, CGPointMake(0, 0)).should == true
    end
  end

  describe "#rect_of_size" do
    it "should work" do
      size = CGSizeMake(20, 30)
      @point.rect_of_size(size).should == CGRectMake(10, 20, 20, 30)
    end
  end

  describe "#+" do
    it "should work with CGSize" do
      size = CGSizeMake(20, 30)
      (@point + size).should == CGRectMake(10, 20, 20, 30)
    end

    it "should work with CGPoint" do
      point = CGPoint.make(x: 100, y: 200)
      (@point + point).should == CGPointMake(110, 220)
    end
  end

  describe "#- (unary)" do
    it "should work" do
      point = CGPoint.make(x: 100, y: 200)
      (-point).should == CGPoint.new(-100, -200)
    end
  end

  describe "#inside?" do
    it "should return true" do
      rect = CGRectMake(0, 0, 100, 100)
      @point.inside?(rect).should == true
    end

    it "should return false" do
      rect = CGRectMake(0, 0, 5, 5)
      @point.inside?(rect).should == false
    end
  end

  describe "#round" do
    it "should work" do
      point = CGPointMake(10.4, 11.5).round
      CGPointEqualToPoint(point, CGPointMake(10, 12)).should == true
    end
  end

  describe "#==?" do
    it "should return true" do
      point = CGPointMake(10, 20)
      @point.should == point
    end

    it "should return false" do
      point = CGPointMake(20, 10)
      @point.should != point
    end
  end
end