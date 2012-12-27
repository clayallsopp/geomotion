describe "CGRect" do
  before do
    @rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
  end

  describe ".make" do
    it "should work with options" do
      CGRectEqualToRect(@rect, CGRectMake(10, 100, 50, 20)).should == true
    end

    it "should work with nested options" do
      CGRectEqualToRect(
        CGRect.make(origin: CGPointMake(10, 100), size: CGSizeMake(50,20)),
        CGRectMake(10, 100, 50, 20)
      ).should == true
    end

    it "should work with no options" do
      CGRectEqualToRect(CGRect.make, CGRectMake(0, 0, 0, 0)).should == true
    end
  end

  describe ".empty" do
    it "should work" do
      CGRectIsEmpty(CGRect.empty).should == true
    end

    it "should not be mutable" do
      f = CGRect.empty
      f.width = 10
      f.height = 10
      f.x = 10
      f.y = 10
      CGRectIsEmpty(CGRect.empty).should == true
    end
  end

  describe "#empty?" do
    it "should work" do
      CGRectZero.empty?.should == true
    end
  end

  describe ".null" do
    it "should work" do
      CGRectIsNull(CGRect.null).should == true
    end

    it "should not be mutable" do
      f = CGRect.null
      f.width = 10
      f.height = 10
      f.x = 10
      f.y = 10
      CGRectIsNull(CGRect.null).should == true
    end
  end

  describe "#null?" do
    it "should work" do
      CGRectNull.null?.should == true
      CGRect.null.null?.should == true
    end
  end

  # Currently does NOT work due to some strange RM bug?
  describe ".infinite" do
    it "should work" do
      CGRect.infinite.infinite?.should == true
    end

    it "should not be mutable" do
      f = CGRect.infinite
      f.width = 10
      f.height = 10
      f.x = 10
      f.y = 10
      CGRect.infinite.infinite?.should == true
    end
  end

  describe "#infinite?" do
    it "should work" do
      CGRect.infinite.infinite?.should == true
      CGRectInfinite.infinite?.should == true
    end
  end

  describe "#intersects?" do
    it "should work" do
      left_rect = CGRectMake(0, 0, 100, 100)
      right_rect = CGRectMake(80, 0, 100, 100)
      left_rect.intersects?(right_rect).should == true
    end
  end

  describe "#contains?" do
    it "should work with CGPoint" do
      left_rect = CGRectMake(0, 0, 100, 100)
      point = CGPointMake(10, 10)
      left_rect.contains?(point).should == true
    end

    it "should work with CGRect" do
      left_rect = CGRectMake(0, 0, 100, 100)
      inner_rect = CGRectMake(80, 0, 10, 10)
      left_rect.contains?(inner_rect).should == true
    end
  end

  describe "#==" do
    it "should return true" do
      @rect.should == CGRectMake(10, 100, 50, 20)
    end

    it "should return false" do
      @rect.should != CGRectMake(10, 100, 50, 10)
    end
  end

  describe ".layout" do
    it "should work without margins" do
      above = CGRectMake(50, 50, 100, 100)
      right_of = CGRectMake(100, 200, 20, 20)

      no_margins = CGRect.layout(@rect, above: above, right_of: right_of)

      CGRectEqualToRect(no_margins, CGRectMake(120, 30, 50, 20)).should == true
    end

    it "should work with margins" do
      above = CGRectMake(50, 50, 100, 100)
      right_of = CGRectMake(100, 200, 20, 20)

      margins = CGRect.layout(@rect, above: above, right_of: right_of, margins: [0, 0, 10, 15])

      CGRectEqualToRect(margins, CGRectMake(135, 20, 50, 20)).should == true
    end
  end

  describe "#x" do
    it "returns value when no args" do
      @rect.x.should == 10
    end

    it "returns copy when has args" do
      rect = @rect.x(20)
      rect.is_a?(CGRect).should == true
      CGRectEqualToRect(rect, CGRectMake(20, 100, 50, 20)).should == true
    end
  end

  describe "#x=" do
    it "sets value" do
      rect = CGRect.empty
      rect.x = 20
      rect.origin.x.should == 20
    end
  end

  describe "#y" do
    it "returns value when no args" do
      @rect.y.should == 100
    end

    it "returns copy when has args" do
      rect = @rect.y(20)
      rect.is_a?(CGRect).should == true
      CGRectEqualToRect(rect, CGRectMake(10, 20, 50, 20)).should == true
    end
  end

  describe "#y=" do
    it "sets value" do
      rect = CGRect.empty
      rect.y = 20
      rect.origin.y.should == 20
    end
  end

  describe "#width" do
    it "returns value when no args" do
      @rect.width.should == 50
    end

    it "returns copy when has args" do
      rect = @rect.width(20)
      rect.is_a?(CGRect).should == true
      CGRectEqualToRect(rect, CGRectMake(10, 100, 20, 20)).should == true
    end
  end

  describe "#width=" do
    it "sets value" do
      rect = CGRect.empty
      rect.width = 20
      rect.size.width.should == 20
    end
  end

  describe "#height" do
    it "returns value when no args" do
      @rect.height.should == 20
    end

    it "returns copy when has args" do
      rect = @rect.height(50)
      rect.is_a?(CGRect).should == true
      CGRectEqualToRect(rect, CGRectMake(10, 100, 50, 50)).should == true
    end
  end

  describe "#height=" do
    it "sets value" do
      rect = CGRect.empty
      rect.height = 50
      rect.size.height.should == 50
    end
  end

  describe "#left" do
    it "works" do
      rect = CGRect.empty
      rect = rect.left(20)
      rect.origin.x.should == -20
    end
  end

  describe "#right" do
    it "works" do
      rect = CGRect.empty.right(20)
      rect.origin.x.should == 20
    end
  end

  describe "#up" do
    it "works" do
      rect = CGRect.empty.up(20)
      rect.origin.y.should == -20
    end
  end

  describe "#down" do
    it "works" do
      rect = CGRect.empty.down(20)
      rect.origin.y.should == 20
    end
  end

  describe "#wider" do
    it "works" do
      rect = CGRect.empty.wider(20)
      rect.size.width.should == 20
    end
  end

  describe "#thinner" do
    it "works" do
      rect = CGRect.empty.thinner(20)
      rect.size.width.should == -20
    end
  end

  describe "#taller" do
    it "works" do
      rect = CGRect.empty.taller(20)
      rect.size.height.should == 20
    end
  end

  describe "#shorter" do
    it "works" do
      rect = CGRect.empty.shorter(20)
      rect.size.height.should == -20
    end
  end

  describe "#above" do
    it "works with margins" do
      rect = CGRect.make(height: 50).above(20)
      rect.origin.y.should == -70
    end

    it "works without margins" do
      rect = CGRect.make(height: 50).above
      rect.origin.y.should == -50
    end
  end

  describe "#below" do
    it "works" do
      rect = CGRect.make(height: 50).below(20)
      rect.origin.y.should == 70
    end
  end

  describe "#before" do
    it "works" do
      rect = CGRect.make(x: 50).before(20)
      rect.origin.x.should == 30
    end
  end

  describe "#before:width:" do
    it "works" do
      rect = CGRect.make(x: 50).before(20, width: 50)
      rect.origin.x.should == -20
    end
  end

  describe "#beside" do
    it "works with margins" do
      rect = CGRect.make(x: 50, width: 20).beside(10)
      rect.origin.x.should == 80
    end

    it "works without margins" do
      rect = CGRect.make(x: 50, width: 20).beside
      rect.origin.x.should == 70
    end
  end

  describe "#beside:width:" do
    it "works" do
      rect = CGRect.make(x: 50, width: 20).beside(10, width: 30)
      rect.origin.x.should == 80
      rect.size.width.should == 30
    end
  end

  describe "#top_left" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.top_left
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(10, 20)).should == true
    end
  end

  describe "#bottom_left" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.bottom_left
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(10, 220)).should == true
    end
  end

  describe "#top_right" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.top_right
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(110, 20)).should == true
    end
  end

  describe "#bottom_right" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.bottom_right
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(110, 220)).should == true
    end
  end

  describe "#center" do
    it "works" do
      point = CGRect.make(width: 100, height: 100).center
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(50, 50)).should == true
    end

    it "works as relative" do
      point = CGRect.make(x: 50, y: 50, width: 100, height: 100).center(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(100, 100)).should == true
    end
  end

  describe "#round" do
    it "works" do
      rect = CGRect.make(x: 10.5, y: 10.4, width: 100.025, height: 100.75)
      CGRectEqualToRect(rect.round, CGRectMake(11, 10, 100, 101)).should == true
    end
  end

  describe "#centered_in" do
    it "works" do
      outer_rect = CGRect.make(width: 100, height: 100)
      inner_rect = CGRect.make(width: 50, height: 50)

      centered_rect = inner_rect.centered_in(outer_rect)
      CGRectEqualToRect(centered_rect, CGRectMake(25, 25, 50, 50)).should == true
    end

    it "works as relative" do
      outer_rect = CGRect.make(x: 20, y: 30, width: 100, height: 100)
      inner_rect = CGRect.make(width: 50, height: 50)

      centered_rect = inner_rect.centered_in(outer_rect, true)
      CGRectEqualToRect(centered_rect, CGRectMake(45, 55, 50, 50)).should == true
    end
  end

  describe "#- (unary)" do
    it "should work" do
      rect = CGRect.make(x: 10, y:10, width: 100, height: 200)
      (-rect).should == CGRect.new([-10, -10], [-100, -200])
    end
  end

  describe "#- (binary)" do
    it "should work" do
      rect = CGRect.make(x: 10, y:10, width: 100, height: 200)
      (rect - rect).should == CGRect.new([-110, -210], [220, 420])
    end
  end

  describe "#+" do
    it "works with CGRect" do
      _rect = CGRectMake(10, 100, 50, 20)
      rect = (_rect + CGRectMake(0, 0, 50, 110))
      CGRectEqualToRect(rect, CGRectMake(0, 0, 60, 120)).should == true
    end

    it "works with CGSize" do
      size = CGSizeMake(50, 20)
      rect = (@rect + size)
      CGRectEqualToRect(rect, CGRectMake(10, 100, 100, 40)).should == true
    end

    it "works with CGPoint" do
      point = CGPointMake(50, 20)
      rect = (@rect + point)
      CGRectEqualToRect(rect, CGRectMake(60, 120, 50, 20)).should == true
    end

    it "works with UIOffset" do
      offset = UIOffsetMake(50, 20)
      rect = (@rect + offset)
      CGRectEqualToRect(rect, CGRectMake(60, 120, 50, 20)).should == true
    end

    it "works with UIEdgeInsets" do
      inset = UIEdgeInsetsMake(10, 10, 10, 5)
      rect = (@rect + inset)
      CGRectEqualToRect(rect, CGRectMake(20, 110, 35, 0)).should == true
    end
  end

  describe "#intersection_with" do
    it "should work" do
      lower_rect = CGRectMake(0, 0, 100, 100)
      upper_rect = CGRectMake(10, 10, 100, 100)
      rect = lower_rect.intersection_with(upper_rect)
      CGRectEqualToRect(rect, CGRectMake(10, 10, 90, 90)).should == true
    end
  end

  describe "#union_with" do
    it "should work" do
      lower_rect = CGRectMake(0, 0, 100, 100)
      upper_rect = CGRectMake(10, 10, 100, 100)
      rect = lower_rect.union_with(upper_rect)
      CGRectEqualToRect(rect, CGRectMake(0, 0, 110, 110)).should == true
    end
  end

  describe "#grow" do
    it "should work with Numeric" do
      rect = @rect.grow(10)
      CGRectEqualToRect(rect, CGRectMake(0, 90, 70, 40)).should == true
    end

    it "should work with CGSize" do
      rect = @rect.grow(CGSizeMake(10, 20))
      CGRectEqualToRect(rect, CGRectMake(0, 80, 70, 60)).should == true
    end
  end

  describe "#shrink" do
    it "should work with Numeric" do
      rect = @rect.shrink(10)
      CGRectEqualToRect(rect, CGRectMake(20, 110, 30, 0)).should == true
    end

    it "should work with CGSize" do
      rect = @rect.shrink(CGSizeMake(20, 10))
      CGRectEqualToRect(rect, CGRectMake(30, 110, 10, 0)).should == true
    end
  end
end