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

  describe "#grow" do
    it "works" do
      size = CGSize.new(0, 0).grow(20)
      size.width.should == 20
      size.height.should == 20
    end
  end

  describe "#shrink" do
    it "works" do
      size = CGSize.new(20, 20).shrink(20)
      size.width.should == 0
      size.height.should == 0
    end
  end

  describe "#wider" do
    it "works" do
      size = CGSize.new(0, 0).wider(20)
      size.width.should == 20
    end
  end

  describe "#thinner" do
    it "works" do
      size = CGSize.new(20, 20).thinner(20)
      size.width.should == 0
    end
  end

  describe "#taller" do
    it "works" do
      size = CGSize.new(0, 0).taller(20)
      size.height.should == 20
    end
  end

  describe "#shorter" do
    it "works" do
      size = CGSize.new(20, 20).shorter(20)
      size.height.should == 0
    end
  end

  describe "#rect_at_point" do
    it "should work" do
      point = CGPointMake(20, 30)
      @size.rect_at_point(point).should == CGRectMake(20, 30, 100, 200)
    end
  end

  describe "#diagonal" do
    it "should work" do
      size = CGSizeMake(30, 40)
      size.diagonal.should == 50.0
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

  describe "#*" do
    it "should work with Numeric" do
      size = CGSizeMake(12, 24)
      bigger = size * 3
      bigger.width.should == 36
      bigger.height.should == 72
    end
  end

  describe "#/" do
    it "should work with Numeric" do
      size = CGSizeMake(12, 24)
      smaller = size / 3
      smaller.width.should == 4
      smaller.height.should == 8
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

  describe '#to/from_ns_value' do
    it 'should convert to NSValue' do
      val = CGSize.new(0, 0).to_ns_value
      val.should.be.kind_of(NSValue)
    end
    it 'should convert from NSValue' do
      val = NSValue.valueWithCGSize(CGSize.new(0, 0))
      size = CGSize.from_ns_value(val)
      size.should.be.kind_of(CGSize)
    end
  end

  describe "#to_ary" do
    it "should allow parallel assigment" do
      width, height = @size
      width.should  == 100.0
      height.should == 200.0
    end
  end

end
