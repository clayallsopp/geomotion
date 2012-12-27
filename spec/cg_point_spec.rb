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

  describe "#up" do
    it "should work" do
      point = CGPointMake(1, 1).up(1)
      CGPointEqualToPoint(point, CGPointMake(1, 0)).should == true
    end
  end

  describe "#down" do
    it "should work" do
      point = CGPointMake(1, 1).down(1)
      CGPointEqualToPoint(point, CGPointMake(1, 2)).should == true
    end
  end

  describe "#left" do
    it "should work" do
      point = CGPointMake(1, 1).left(1)
      CGPointEqualToPoint(point, CGPointMake(0, 1)).should == true
    end
  end

  describe "#right" do
    it "should work" do
      point = CGPointMake(1, 1).right(1)
      CGPointEqualToPoint(point, CGPointMake(2, 1)).should == true
    end
  end

  describe "#chaining up().down().left().right()" do
    it "should work" do
      point = CGPointMake(1, 1).up(2).down(1).left(2).right(1)
      CGPointEqualToPoint(point, CGPointMake(0, 0)).should == true
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

  describe "#- (binary)" do
    it "should work" do
      point = CGPoint.make(x: 100, y: 200)
      (point - point).should == CGPoint.new(0, 0)
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