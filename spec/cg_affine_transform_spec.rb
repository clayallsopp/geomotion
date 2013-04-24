describe "CGAffineTransform" do

  describe "operations" do

    it "should support ==" do
      CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0).should == CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
    end

    it "should support +" do
      t1 = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
      t2 = CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 10, ty: 10)
      (t1 + t2).should == CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 10, ty: 10)
    end

    it "should support <<" do
      t1 = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
      t2 = CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 10, ty: 10)
      (t1 << t2).should == CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 10, ty: 10)
    end

    it "should support -" do
      t1 = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
      t2 = CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 10, ty: 10)
      (t1 - t2).should == CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: -10, ty: -10)
    end

    it "subtracting itself should return identity (scale)" do
      t1 = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
      t2 = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
      (t1 - t2).should == CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    end

    it "subtracting itself should return identity (translate)" do
      t1 = CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 10, ty: 10)
      t2 = CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 10, ty: 10)
      (t1 - t2).should == CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    end

    it "subtracting itself should return identity (rotate)" do
      t1 = CGAffineTransform.make(a: -1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
      t2 = CGAffineTransform.make(a: -1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
      (t1 - t2).should == CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    end

    it "should support unary -" do
      (- CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)).should == CGAffineTransform.make(a: 0.5, b: 0, c: 0, d: 0.5, tx: 0, ty: 0)
    end

    it "should support unary +" do
      (+ CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)).should == CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    end

  end

  describe ".make" do

    it "should work with no arguments" do
      transform = CGAffineTransform.make
      transform.should == CGAffineTransformMake(1, 0, 0, 1, 0, 0)
    end

    it "should work with options" do
      transform = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
      transform.should == CGAffineTransformMake(2, 0, 0, 2, 0, 0)
    end

    it "should work with transform options (scale)" do
      CGAffineTransform.make(scale: [2, 3]).should == CGAffineTransformMake(2, 0, 0, 3, 0, 0)
    end

    it "should work with transform options (translate)" do
      CGAffineTransform.make(translate: [10, 20]).should == CGAffineTransformMake(1, 0, 0, 1, 10, 20)
    end

    it "should work with transform options (rotate)" do
      transform = CGAffineTransform.make(rotate: Math::PI).to_a.map { |v| v.round(3) }
      CGAffineTransform.new(*transform).should == CGAffineTransformMake(-1, 0, 0, -1, 0, 0)
    end

    it "should work with transform options (scale + translate)" do
      CGAffineTransform.make(scale: [2, 3], translate: [10, 20]).should == CGAffineTransformMake(2, 0, 0, 3, 10, 20)
    end

    it "should work with transform options (scale + translate + rotation)" do
      transform = CGAffineTransform.make(scale: [2, 3], rotate: Math::PI, translate: [10, 10]).to_a.map { |v| v.round(3) }
      CGAffineTransform.new(*transform).should == CGAffineTransformMake(-2, 0, 0, -3, 10, 10)
    end

  end

  describe "identity" do

    it "should return the identity matrix" do
      CGAffineTransformIsIdentity(CGAffineTransform.identity).should == true
    end

    it "identity? should return true for identity matrix" do
      CGAffineTransform.identity.identity?.should == true
    end

    it "identity? should return false other matrices" do
      CGAffineTransform.new(2, 0, 0, 2, 0, 0).identity?.should == false
    end

  end

  describe ".rotate" do

    it "should work as a factory" do
      transform = CGAffineTransform.rotate(Math::PI).to_a.map { |v| v.round(3) }
      CGAffineTransform.new(*transform).should == CGAffineTransformMake(-1, 0, 0, -1, 0, 0)
    end

    it "should work as an instance method" do
      transform = CGAffineTransform.identity.rotate(Math::PI).to_a.map { |v| v.round(3) }
      CGAffineTransform.new(*transform).should == CGAffineTransformMake(-1, 0, 0, -1, 0, 0)
    end

  end

  describe ".scale" do

    it "should work as a factory with one argument" do
      CGAffineTransform.scale(2).should == CGAffineTransformMake(2, 0, 0, 2, 0, 0)
    end

    it "should work as a factory with two arguments" do
      CGAffineTransform.scale(2, 3).should == CGAffineTransformMake(2, 0, 0, 3, 0, 0)
    end

    it "should work as a factory with one array" do
      CGAffineTransform.scale([2, 3]).should == CGAffineTransformMake(2, 0, 0, 3, 0, 0)
    end

    it "should work as an instance method with one argument" do
      CGAffineTransform.identity.scale(2).should == CGAffineTransformMake(2, 0, 0, 2, 0, 0)
    end

    it "should work as an instance method with two arguments" do
      CGAffineTransform.identity.scale(2, 3).should == CGAffineTransformMake(2, 0, 0, 3, 0, 0)
    end

    it "should work as an instance method with one array" do
      CGAffineTransform.identity.scale([2, 3]).should == CGAffineTransformMake(2, 0, 0, 3, 0, 0)
    end

  end

  describe ".translate" do

    it "should work as a factory with two arguments" do
      CGAffineTransform.translate(10, 20).should == CGAffineTransformMake(1, 0, 0, 1, 10, 20)
    end

    it "should work as a factory with one array" do
      CGAffineTransform.translate([10, 20]).should == CGAffineTransformMake(1, 0, 0, 1, 10, 20)
    end

    it "should work as an instance method with two arguments" do
      CGAffineTransform.identity.translate(10, 20).should == CGAffineTransformMake(1, 0, 0, 1, 10, 20)
    end

    it "should work as an instance method with one array" do
      CGAffineTransform.identity.translate([10, 20]).should == CGAffineTransformMake(1, 0, 0, 1, 10, 20)
    end

  end

  describe "apply_to" do

    before do
      @transform = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 3, tx: 10, ty: 20)
    end

    it "should work on a point" do
      thing = CGPoint.new(0, 0)
      @transform.apply_to(thing).should == CGPoint.new(10, 20)
    end

    it "should work on a size" do
      thing = CGSize.new(10, 10)
      @transform.apply_to(thing).should == CGSize.new(20, 30)
    end

    it "should work on a rect" do
      thing = CGRect.new([0, 0], [10, 10])
      @transform.apply_to(thing).should == CGRect.new([10, 20], [20, 30])
    end

    it "should not work on anything else" do
      ->{ @transform.apply_to(1) }.should.raise
      ->{ @transform.apply_to([0, 0]) }.should.raise
    end

  end

  describe "other methods" do

    it "should support concat" do
      t1 = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
      t2 = CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 10, ty: 10)
      t1.concat(t2).should == CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 10, ty: 10)
    end

    it "should support invert" do
      t1 = CGAffineTransform.make(a: 2, b: 0, c: 0, d: 2, tx: 0, ty: 0)
      t1.invert.should == CGAffineTransform.make(a: 0.5, b: 0, c: 0, d: 0.5, tx: 0, ty: 0)
    end

  end

end
