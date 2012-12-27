describe "CGSize" do
  before do
    @size = CGSize.make(width: 100, height: 200)
  end

  describe ".make" do
    it "should work with options" do
      CGSizeEqualToSize(@size, CGSizeMake(100, 200)).should == true
    end

    it "should work with no options" do
      CGSizeEqualToSize(CGSize.make, CGSizeMake(0, 0)).should == true
    end
  end

  describe "#rect_at_point" do
    it "should work" do
      point = CGPointMake(20, 30)
      @size.rect_at_point(point).should == CGRectMake(20, 30, 100, 200)
    end
  end

  describe "#- (unary)" do
    it "should work" do
      size = CGSize.make(width: 100, height: 200)
      (-size).should == CGSize.new(-100, -200)
    end
  end

  describe "#- (binary)" do
    it "should work" do
      size = CGSize.make(width: 100, height: 200)
      (size - size).should == CGSize.new(0, 0)
    end
  end

  describe "#+" do
    it "should work with CGSize" do
      size = CGSizeMake(20, 30)
      (@size + size).should == CGSizeMake(120, 230)
    end

    it "should work with CGPoint" do
      point = CGPointMake(20, 30)
      (@size + point).should == CGRectMake(20, 30, 100, 200)
    end
  end

  describe "#infinite?" do
    it "should return true" do
      infinite = CGSize.infinite
      infinite.infinite?.should == true
    end
  end

  describe ".empty" do
    it "should work" do
      CGRectIsEmpty(CGSize.empty.rect_at_point([0, 0])).should == true
    end

    it "should not be mutable" do
      f = CGSize.empty
      f.width = 10
      f.height = 10
      CGRectIsEmpty(CGSize.empty.rect_at_point([0, 0])).should == true
    end
  end

  describe "#empty?" do
    it "should return true" do
      empty = CGSizeMake(0, 0)
      empty.empty?.should == true
    end
  end

  describe "#==?" do
    it "should return true" do
      size = CGSizeMake(100, 200)
      @size.should == size
    end

    it "should return false" do
      size = CGSizeMake(20, 10)
      @size.should != size
    end
  end

  describe "#centered_in" do
    it "works" do
      outer_rect = CGRect.make(width: 100, height: 100)
      inner_size = CGSize.make(width: 50, height: 50)

      centered_rect = inner_size.centered_in(outer_rect)
      CGRectEqualToRect(centered_rect, CGRectMake(25, 25, 50, 50)).should == true
    end

    it "works as relative" do
      outer_rect = CGRect.make(x: 20, y: 30, width: 100, height: 100)
      inner_size = CGSize.make(width: 50, height: 50)

      centered_rect = inner_size.centered_in(outer_rect, true)
      CGRectEqualToRect(centered_rect, CGRectMake(45, 55, 50, 50)).should == true
    end
  end

end