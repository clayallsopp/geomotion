describe "CGRect" do
  before do
    @rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
  end

  describe ".make" do
    it "should work with options" do
      CGRectEqualToRect(@rect, CGRectMake(10, 100, 50, 20)).should == true
    end

    it "should work with nested options (CGPoint, CGSize)" do
      CGRectEqualToRect(
        CGRect.make(origin: CGPointMake(10, 100), size: CGSizeMake(50,20)),
        CGRectMake(10, 100, 50, 20)
      ).should == true
    end

    it "should work with nested options (Arrays)" do
      CGRectEqualToRect(
        CGRect.make(origin: [10, 100], size: [50,20]),
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
    it "returns min_x when width is negative" do
      rect = CGRect.make(x: 110, y: 10, width: -100, height: 100)
      rect.x.should == 10
      rect.origin.x.should == 110
    end

    it "returns copy when has args" do
      rect = @rect.x(20)
      rect.is_a?(CGRect).should == true
      rect.should == CGRectMake(20, 100, 50, 20)
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
    it "returns min_y when height is negative" do
      rect = CGRect.make(x: 10, y: 110, width: 100, height: -100)
      rect.y.should == 10
      rect.origin.y.should == 110
    end

    it "returns copy when has args" do
      rect = @rect.y(20)
      rect.is_a?(CGRect).should == true
      rect.should == CGRectMake(10, 20, 50, 20)
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
    it "always returns positive width" do
      rect = CGRect.make(x: 10, y: 110, width: -100, height: -100)
      rect.width.should == 100
    end
    it "returns copy when has args" do
      rect = @rect.width(20)
      rect.is_a?(CGRect).should == true
      rect.should == CGRectMake(10, 100, 20, 20)
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
    it "always returns positive height" do
      rect = CGRect.make(x: 10, y: 110, width: -100, height: -100)
      rect.height.should == 100
    end
    it "returns copy when has args" do
      rect = @rect.height(50)
      rect.is_a?(CGRect).should == true
      rect.should == CGRectMake(10, 100, 50, 50)
    end
  end

  describe "#height=" do
    it "sets value" do
      rect = CGRect.empty
      rect.height = 50
      rect.size.height.should == 50
    end
  end

  describe "#min_x, #mid_x, #max_x, #min_y, #mid_y, #max_y" do
    before do
      @min_rect = CGRect.make(x: 10, y: 10, width: 100, height: 100)
      @min_rect_negative = CGRect.make(x: 110, y: 110, width: -100, height: -100)
    end

    it "#min_x works" do
      @min_rect.min_x.should == 10
    end
    it "#mid_x works" do
      @min_rect.mid_x.should == 60
    end
    it "#max_x works" do
      @min_rect.max_x.should == 110
    end
    it "#min_x works with negative width" do
      @min_rect_negative.min_x.should == 10
    end
    it "#mid_x works with negative width" do
      @min_rect_negative.mid_x.should == 60
    end
    it "#max_x works with negative width" do
      @min_rect_negative.max_x.should == 110
    end

    it "#min_y works" do
      @min_rect.min_y.should == 10
    end
    it "#mid_y works" do
      @min_rect.mid_y.should == 60
    end
    it "#max_y works" do
      @min_rect.max_y.should == 110
    end
    it "#min_y works with negative height" do
      @min_rect_negative.min_y.should == 10
    end
    it "#mid_y works with negative height" do
      @min_rect_negative.mid_y.should == 60
    end
    it "#max_y works with negative height" do
      @min_rect_negative.max_y.should == 110
    end
  end

  describe "#left" do
    it "works" do
      rect = CGRect.empty.left(20)
      rect.origin.x.should == -20
    end

    it "works with options" do
      rect = CGRect.empty.left(20, width: 20)
      rect.origin.x.should == -20
      rect.size.width.should == 20
    end
  end

  describe "#right" do
    it "works" do
      rect = CGRect.empty.right(20)
      rect.origin.x.should == 20
    end

    it "works with options" do
      rect = CGRect.empty.right(20, width: 20)
      rect.origin.x.should == 20
      rect.size.width.should == 20
    end
  end

  describe "#up" do
    it "works" do
      rect = CGRect.empty.up(20)
      rect.origin.y.should == -20
    end

    it "works with options" do
      rect = CGRect.empty.up(20, height: 20)
      rect.origin.y.should == -20
      rect.size.height.should == 20
    end
  end

  describe "#down" do
    it "works" do
      rect = CGRect.empty.down(20)
      rect.origin.y.should == 20
    end

    it "works with options" do
      rect = CGRect.empty.down(20, height: 20)
      rect.origin.y.should == 20
      rect.size.height.should == 20
    end
  end

  describe "#wider" do
    it "works" do
      rect = CGRect.empty.wider(20)
      rect.size.width.should == 20
    end

    it "works with options" do
      rect = CGRect.empty.wider(20, height: 20)
      rect.size.width.should == 20
      rect.size.height.should == 20
    end
  end

  describe "#thinner" do
    it "works" do
      rect = CGRect.make(width: 20).thinner(10)
      rect.size.width.should == 10
    end

    it "works with options" do
      rect = CGRect.make(width: 20).thinner(10, height: 20)
      rect.size.width.should == 10
      rect.size.height.should == 20
    end
  end

  describe "#taller" do
    it "works" do
      rect = CGRect.make(height: 20).taller(20)
      rect.size.height.should == 40
    end

    it "works with options" do
      rect = CGRect.make(height: 20).taller(20, width: 20)
      rect.size.width.should == 20
      rect.size.height.should == 40
    end
  end

  describe "#shorter" do
    it "works" do
      rect = CGRect.make(height: 20).shorter(10)
      rect.size.height.should == 10
    end

    it "works with options" do
      rect = CGRect.make(height: 20).shorter(10, width: 20)
      rect.size.width.should == 20
      rect.size.height.should == 10
    end
  end

  describe "#above" do
    it "works without margins" do
      rect = CGRect.make(height: 50).above
      rect.origin.y.should == -50
      rect.size.height.should == 50
    end

    it "works with margins" do
      rect = CGRect.make(height: 50).above(20)
      rect.origin.y.should == -70
      rect.size.height.should == 50
    end

    it "works with options" do
      rect = CGRect.make(height: 50).above(20, height: 10)
      rect.origin.y.should == -30
      rect.size.height.should == 10
    end

    it "works with options and no margin" do
      rect = CGRect.make(height: 50).above(height: 10)
      rect.origin.y.should == -10
      rect.size.height.should == 10
    end
  end

  describe "#below" do
    it "works without margins" do
      rect = CGRect.make(height: 50).below
      rect.origin.y.should == 50
      rect.size.height.should == 50
    end

    it "works with margins" do
      rect = CGRect.make(height: 50).below(20)
      rect.origin.y.should == 70
      rect.size.height.should == 50
    end

    it "works with options" do
      rect = CGRect.make(height: 50).below(20, height: 10)
      rect.origin.y.should == 70
      rect.size.height.should == 10
    end

    it "works with options and no margin" do
      rect = CGRect.make(height: 50).below(height: 10)
      rect.origin.y.should == 50
      rect.size.height.should == 10
    end
  end

  describe "#before" do
    it "works without margins" do
      rect = CGRect.make(width: 50).before
      rect.origin.x.should == -50
      rect.size.width.should == 50
    end

    it "works with margins" do
      rect = CGRect.make(width: 50).before(20)
      rect.origin.x.should == -70
      rect.size.width.should == 50
    end

    it "works with options" do
      rect = CGRect.make(width: 50).before(20, width: 10)
      rect.origin.x.should == -30
      rect.size.width.should == 10
    end

    it "works with options and no margin" do
      rect = CGRect.make(width: 50).before(width: 10)
      rect.origin.x.should == -10
      rect.size.width.should == 10
    end
  end

  describe "#beside" do
    it "works without margins" do
      rect = CGRect.make(width: 50).beside
      rect.origin.x.should == 50
      rect.size.width.should == 50
    end

    it "works with margins" do
      rect = CGRect.make(width: 50).beside(20)
      rect.origin.x.should == 70
      rect.size.width.should == 50
    end

    it "works with options" do
      rect = CGRect.make(width: 50).beside(20, width: 10)
      rect.origin.x.should == 70
      rect.size.width.should == 10
    end

    it "works with options and no margin" do
      rect = CGRect.make(width: 50).beside(width: 10)
      rect.origin.x.should == 50
      rect.size.width.should == 10
    end
  end

  describe "#top_left" do
    it "works with margins" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.top_left
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(0, 0)).should == true
    end

    it "works as relative" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.top_left(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(10, 20)).should == true
    end
  end

  describe "#top_center" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.top_center
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(50, 0)).should == true
    end

    it "works as relative" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.top_center(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(60, 20)).should == true
    end
  end

  describe "#top_right" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.top_right
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(100, 0)).should == true
    end

    it "works as relative" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.top_right(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(110, 20)).should == true
    end
  end

  describe "#center_right" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.center_right
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(100, 100)).should == true
    end

    it "works as relative" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.center_right(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(110, 120)).should == true
    end
  end

  describe "#bottom_right" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.bottom_right
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(100, 200)).should == true
    end

    it "works as relative" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.bottom_right(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(110, 220)).should == true
    end
  end

  describe "#bottom_center" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.bottom_center
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(50, 200)).should == true
    end

    it "works as relative" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.bottom_center(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(60, 220)).should == true
    end
  end

  describe "#bottom_left" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.bottom_left
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(0, 200)).should == true
    end

    it "works as relative" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.bottom_left(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(10, 220)).should == true
    end
  end

  describe "#center_left" do
    it "works" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.center_left
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(0, 100)).should == true
    end

    it "works as relative" do
      rect = CGRect.make(x: 10, y: 20, width: 100, height: 200)
      point = rect.center_left(true)
      point.is_a?(CGPoint).should == true
      CGPointEqualToPoint(point, CGPointMake(10, 120)).should == true
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
      rect.should == CGRectMake(0, 0, 60, 120)
    end

    it "works with CGSize" do
      size = CGSizeMake(50, 20)
      rect = (@rect + size)
      rect.should == CGRectMake(10, 100, 100, 40)
    end

    it "works with CGPoint" do
      point = CGPointMake(50, 20)
      rect = (@rect + point)
      rect.should == CGRectMake(60, 120, 50, 20)
    end

    it "works with UIOffset" do
      offset = UIOffsetMake(50, 20)
      rect = (@rect + offset)
      rect.should == CGRectMake(60, 120, 50, 20)
    end

    it "works with UIEdgeInsets" do
      insets = UIEdgeInsetsMake(10, 10, 10, 5)
      rect = (@rect + insets)
      rect.should == CGRectMake(20, 110, 35, 0)
    end
  end

  describe "offset" do
    it "works with x, y" do
      rect = @rect.offset(50, 20)
      rect.should == CGRectMake(60, 120, 50, 20)
    end

    it "works with CGPoint" do
      point = CGPointMake(50, 20)
      rect = @rect.offset(point)
      rect.should == CGRectMake(60, 120, 50, 20)
    end

    it "works with UIOffset" do
      offset = UIOffsetMake(50, 20)
      rect = @rect.offset(offset)
      rect.should == CGRectMake(60, 120, 50, 20)
    end
  end

  describe "inset" do
    it "works with UIEdgeInsets" do
      insets = UIEdgeInsetsMake(10, 10, 10, 5)
      rect = @rect.inset(insets)
      rect.should == CGRectMake(20, 110, 35, 0)
    end
  end

  describe "#*" do
    it "should work with Numeric" do
      rect = CGRectMake(0, 0, 12, 24)
      bigger = rect * 3
      bigger.size.width.should == 36
      bigger.size.height.should == 72
    end
  end

  describe "#/" do
    it "should work with Numeric" do
      rect = CGRectMake(0, 0, 12, 24)
      smaller = rect / 3
      smaller.size.width.should == 4
      smaller.size.height.should == 8
    end
  end

  describe "#intersection_with" do
    it "should work" do
      lower_rect = CGRectMake(0, 0, 100, 100)
      upper_rect = CGRectMake(10, 10, 100, 100)
      rect = lower_rect.intersection_with(upper_rect)
      rect.should == CGRectMake(10, 10, 90, 90)
    end
  end

  describe "#union_with" do
    it "should work" do
      lower_rect = CGRectMake(0, 0, 100, 100)
      upper_rect = CGRectMake(10, 10, 100, 100)
      rect = lower_rect.union_with(upper_rect)
      rect.should == CGRectMake(0, 0, 110, 110)
    end
  end

  describe "#grow" do
    it "should work with Numeric" do
      rect = @rect.grow(10)
      rect.should == CGRectMake(0, 90, 70, 40)
    end

    it "should work with CGSize" do
      rect = @rect.grow(CGSizeMake(10, 20))
      rect.should == CGRectMake(0, 80, 70, 60)
    end
  end

  describe "#grow_left" do
    # @rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
    it "should work" do
      rect = @rect.grow_left(10)
      rect.should == CGRectMake(0, 100, 60, 20)
    end
    it "should work with options" do
      rect = @rect.grow_left(10, height: 5)
      rect.should == CGRectMake(0, 100, 60, 5)
    end
  end

  describe "#grow_right" do
    it "should work" do
      rect = @rect.grow_right(10)
      rect.should == CGRectMake(10, 100, 60, 20)
    end
    it "should work with options" do
      rect = @rect.grow_right(10, height: 5)
      rect.should == CGRectMake(10, 100, 60, 5)
    end
  end

  describe "#grow_up" do
    it "should work" do
      rect = @rect.grow_up(10)
      rect.should == CGRectMake(10, 90, 50, 30)
    end
    it "should work with options" do
      rect = @rect.grow_up(10, width: 5)
      rect.should == CGRectMake(10, 90, 5, 30)
    end
  end

  describe "#grow_down" do
    it "should work" do
      rect = @rect.grow_down(10)
      rect.should == CGRectMake(10, 100, 50, 30)
    end
    it "should work with options" do
      rect = @rect.grow_down(10, width: 5)
      rect.should == CGRectMake(10, 100, 5, 30)
    end
  end

  describe "#grow_width" do
    # @rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
    it "should work" do
      rect = @rect.grow_width(10)
      rect.should == CGRectMake(0, 100, 70, 20)
    end
  end

  describe "#grow_height" do
    it "should work" do
      rect = @rect.grow_height(10)
      rect.should == CGRectMake(10, 90, 50, 40)
    end
  end

  describe "#shrink" do
    it "should work with Numeric" do
      rect = @rect.shrink(10)
      rect.should == CGRectMake(20, 110, 30, 0)
    end

    it "should work with CGSize" do
      rect = @rect.shrink(CGSizeMake(20, 10))
      rect.should == CGRectMake(30, 110, 10, 0)
    end

    it "should work with Array" do
      rect = @rect.shrink([20, 10])
      rect.should == CGRectMake(30, 110, 10, 0)
    end
  end

  describe "#shrink_left" do
    it "should work" do
      rect = @rect.shrink_left(10)
      rect.should == CGRectMake(10, 100, 40, 20)
    end
  end

  describe "#shrink_right" do
    it "should work" do
      rect = @rect.shrink_right(10)
      rect.should == CGRectMake(20, 100, 40, 20)
    end
  end

  describe "#shrink_up" do
    it "should work" do
      rect = @rect.shrink_up(10)
      rect.should == CGRectMake(10, 100, 50, 10)
    end
  end

  describe "#shrink_down" do
    it "should work" do
      rect = @rect.shrink_down(10)
      rect.should == CGRectMake(10, 110, 50, 10)
    end
  end

  describe "#shrink_width" do
    # @rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
    it "should work" do
      rect = @rect.shrink_width(10)
      rect.should == CGRectMake(20, 100, 30, 20)
    end
  end

  describe "#shrink_height" do
    it "should work" do
      rect = @rect.shrink_height(10)
      rect.should == CGRectMake(10, 110, 50, 0)
    end
  end

  describe "#apply" do

    it "should support :left" do
      rect = @rect.apply(left: 10)
      rect.should == CGRectMake(0, 100, 50, 20)
    end

    it "should support :right" do
      rect = @rect.apply(right: 10)
      rect.should == CGRectMake(20, 100, 50, 20)
    end

    it "should support :up" do
      rect = @rect.apply(up: 10)
      rect.should == CGRectMake(10, 90, 50, 20)
    end

    it "should support :down" do
      rect = @rect.apply(down: 10)
      rect.should == CGRectMake(10, 110, 50, 20)
    end

    it "should support :wider" do
      rect = @rect.apply(wider: 10)
      rect.should == CGRectMake(10, 100, 60, 20)
    end

    it "should support :thinner" do
      rect = @rect.apply(thinner: 10)
      rect.should == CGRectMake(10, 100, 40, 20)
    end

    it "should support :taller" do
      rect = @rect.apply(taller: 10)
      rect.should == CGRectMake(10, 100, 50, 30)
    end

    it "should support :shorter" do
      rect = @rect.apply(shorter: 10)
      rect.should == CGRectMake(10, 100, 50, 10)
    end

    it "should support :x" do
      rect = @rect.apply(x: 11)
      rect.should == CGRectMake(11, 100, 50, 20)
    end

    it "should support :y" do
      rect = @rect.apply(y: 10)
      rect.should == CGRectMake(10, 10, 50, 20)
    end

    it "should support :origin" do
      rect = @rect.apply(origin: [11, 10])
      rect.should == CGRectMake(11, 10, 50, 20)
    end

    it "should support :width" do
      rect = @rect.apply(width: 10)
      rect.should == CGRectMake(10, 100, 10, 20)
    end

    it "should support :height" do
      rect = @rect.apply(height: 10)
      rect.should == CGRectMake(10, 100, 50, 10)
    end

    it "should support :size" do
      rect = @rect.apply(size: [10, 10])
      rect.should == CGRectMake(10, 100, 10, 10)
    end

    it "should support :grow" do
      rect = @rect.apply(grow: 10)
      rect.should == CGRectMake(0, 90, 70, 40)
    end

    it "should support :grow_up" do
      rect = @rect.apply(grow_up: 10)
      rect.should == CGRectMake(10, 90, 50, 30)
    end

    it "should support :shrink_down" do
      rect = @rect.apply(shrink_down: 10)
      rect.should == CGRectMake(10, 110, 50, 10)
    end

    it "should support :grow_left" do
      rect = @rect.apply(grow_left: 10)
      rect.should == CGRectMake(0, 100, 60, 20)
    end

    it "should support :shrink_right" do
      rect = @rect.apply(shrink_right: 10)
      rect.should == CGRectMake(20, 100, 40, 20)
    end

    it "should support :grow_width" do
      rect = @rect.apply(grow_width: 10)
      rect.should == CGRectMake(0, 100, 70, 20)
    end

    it "should support :grow_height" do
      rect = @rect.apply(grow_height: 10)
      rect.should == CGRectMake(10, 90, 50, 40)
    end

    it "should support :shrink" do
      rect = @rect.apply(shrink: 10)
      rect.should == CGRectMake(20, 110, 30, 0)
    end

    it "should support :shrink_width" do
      rect = @rect.apply(shrink_width: 10)
      rect.should == CGRectMake(20, 100, 30, 20)
    end

    it "should support :shrink_height" do
      rect = @rect.apply(shrink_height: 10)
      rect.should == CGRectMake(10, 110, 50, 0)
    end

    it "should support :offset" do
      rect = @rect.apply(offset: [10, 10])
      rect.should == CGRectMake(20, 110, 50, 20)
    end

  end

  describe "#from_left" do
    it "should work" do
      rect = @rect.from_left(width: 10)
      rect.should == CGRectMake(0, 0, 10, 20)
    end
    it "should work with margin" do
      rect = @rect.from_left(width: 10, margin: 5)
      rect.should == CGRectMake(5, 0, 10, 20)
    end
  end

  describe "#from_right" do
    it "should work" do
      rect = @rect.from_right(width: 10)
      rect.should == CGRectMake(40, 0, 10, 20)
    end
    it "should work with margin" do
      rect = @rect.from_right(width: 10, margin: 5)
      rect.should == CGRectMake(35, 0, 10, 20)
    end
  end

  describe "#from_top" do
    it "should work" do
      rect = @rect.from_top(height: 10)
      rect.should == CGRectMake(0, 0, 50, 10)
    end
    it "should work with margin" do
      rect = @rect.from_top(height: 10, margin: 5)
      rect.should == CGRectMake(0, 5, 50, 10)
    end
  end

  describe "#from_bottom" do
    it "should work" do
      rect = @rect.from_bottom(height: 10)
      rect.should == CGRectMake(0, 10, 50, 10)
    end
    it "should work with margin" do
      rect = @rect.from_bottom(height: 10, margin: 5)
      rect.should == CGRectMake(0, 5, 50, 10)
    end
  end

end
