describe "CATransform3D" do

  describe "operations" do

    it "should support ==" do
      CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
      ).should == CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
      )
    end

    it "should support +" do
      t1 = CATransform3D.make(
        m11: 2, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 2, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 2, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
      t2 = CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
        )
      (t1 + t2).should == CATransform3D.make(
        m11: 2, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 2, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 2, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
        )
    end

    it "should support <<" do
      t1 = CATransform3D.make(
        m11: 2, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 2, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 2, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
      t2 = CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
        )
      (t1 << t2).should == CATransform3D.make(
        m11: 2, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 2, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 2, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
        )
    end

    it "should support -" do
      t1 = CATransform3D.make(
        m11: 2, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 2, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 2, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
      t2 = CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
        )
      (t1 - t2).should == CATransform3D.make(
        m11: 2, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 2, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 2, m34: 0,
        m41: -1, m42: -2, m43: -3, m44: 1,
        )
    end

    it "subtracting itself should return identity (scale)" do
      t1 = CATransform3D.make(
        m11: 2, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 2, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 2, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
      (t1 - t1).should == CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
    end

    it "subtracting itself should return identity (translate)" do
      t1 = CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
        )
      (t1 - t1).should == CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
    end

    it "subtracting itself should return identity (rotate)" do
      t1 = CATransform3D.make(
        m11:-1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22:-1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
      (t1 - t1).should == CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
    end

    it "should support unary -" do
      (- CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
      )).should == CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41:-1, m42:-2, m43:-3, m44: 1,
      )
    end

    it "should support unary +" do
      (+ CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
      )).should == CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 1, m42: 2, m43: 3, m44: 1,
      )
    end

  end

  describe ".make" do

    it "should work with no arguments" do
      transform = CATransform3D.make
      transform.should == CATransform3D.identity
    end

    it "should work with options" do
      transform = CATransform3D.make(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
        )
      CATransform3DIsIdentity(transform).should == true
    end

    it "should work with transform options (scale)" do
      CATransform3D.make(scale: [2, 3, 4]).should == CATransform3D.new(2,0,0,0, 0,3,0,0, 0,0,4,0, 0,0,0,1)
    end

    it "should work with transform options (translate)" do
      CATransform3D.make(translate: [10, 20, 30]).should == CATransform3D.new(1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,30,1)
    end

    it "should work with transform options (rotate)" do
      transform = CATransform3D.make(rotate: Math::PI).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(-1,0,0,0, 0,-1,0,0, 0,0,1,0, 0,0,0,1)
    end

    it "should work with transform options (scale + translate)" do
      CATransform3D.make(scale: [2, 3, 4], translate: [10, 20, 30]).should == CATransform3D.new(2,0,0,0, 0,3,0,0, 0,0,4,0, 10,20,30,1)
    end

    it "should work with transform options (scale + translate + rotation)" do
      transform = CATransform3D.make(scale: [2, 3, 4], rotate: Math::PI, translate: [10, 20, 30]).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(-2,0,0,0, 0,-3,0,0, 0,0,4,0, 10,20,30,1)
    end

  end

  describe "identity" do

    it "should return the identity matrix" do
      CATransform3DIsIdentity(CATransform3D.identity).should == true
    end

    it "identity? should return true for identity matrix" do
      CATransform3D.identity.identity?.should == true
    end

    it "identity? should return false other matrices" do
      CATransform3D.scale(2).identity?.should == false
    end

  end

  describe ".rotate" do

    it "should work as a factory (x-axis)" do
      transform = CATransform3D.rotate(Math::PI, 1, 0, 0).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(1,0,0,0, 0,-1,0,0, 0,0,-1,0, 0,0,0,1)
    end

    it "should work as a factory (y-axis)" do
      transform = CATransform3D.rotate(Math::PI, 0, 1, 0).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(-1,0,0,0, 0,1,0,0, 0,0,-1,0, 0,0,0,1)
    end

    it "should work as a factory (z-axis)" do
      transform = CATransform3D.rotate(Math::PI, 0, 0, 1).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(-1,0,0,0, 0,-1,0,0, 0,0,1,0, 0,0,0,1)
    end

    it "should work as a factory (default)" do
      transform = CATransform3D.rotate(Math::PI).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(-1,0,0,0, 0,-1,0,0, 0,0,1,0, 0,0,0,1)
    end

    it "should work as an instance method (x-axis)" do
      transform = CATransform3D.identity.rotate(Math::PI, 1, 0, 0).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(1,0,0,0, 0,-1,0,0, 0,0,-1,0, 0,0,0,1)
    end

    it "should work as an instance method (y-axis)" do
      transform = CATransform3D.identity.rotate(Math::PI, 0, 1, 0).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(-1,0,0,0, 0,1,0,0, 0,0,-1,0, 0,0,0,1)
    end

    it "should work as an instance method (z-axis)" do
      transform = CATransform3D.identity.rotate(Math::PI, 0, 0, 1).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(-1,0,0,0, 0,-1,0,0, 0,0,1,0, 0,0,0,1)
    end

    it "should work as an instance method (default)" do
      transform = CATransform3D.identity.rotate(Math::PI).to_a.map { |v| v.round(3) }
      CATransform3D.new(*transform).should == CATransform3D.new(-1,0,0,0, 0,-1,0,0, 0,0,1,0, 0,0,0,1)
    end

  end

  describe ".scale" do

    it "should work as a factory with one argument" do
      CATransform3D.scale(2).should == CATransform3D.new(2,0,0,0, 0,2,0,0, 0,0,1,0, 0,0,0,1)
    end

    it "should work as a factory with three arguments" do
      CATransform3D.scale(2, 3, 4).should == CATransform3D.new(2,0,0,0, 0,3,0,0, 0,0,4,0, 0,0,0,1)
    end

    it "should work as a factory with one array" do
      CATransform3D.scale([2, 3, 4]).should == CATransform3D.new(2,0,0,0, 0,3,0,0, 0,0,4,0, 0,0,0,1)
    end

    it "should work as an instance method with one argument" do
      CATransform3D.identity.scale(2).should == CATransform3D.new(2,0,0,0, 0,2,0,0, 0,0,1,0, 0,0,0,1)
    end

    it "should work as an instance method with three arguments" do
      CATransform3D.identity.scale(2, 3, 4).should == CATransform3D.new(2,0,0,0, 0,3,0,0, 0,0,4,0, 0,0,0,1)
    end

    it "should work as an instance method with one array" do
      CATransform3D.identity.scale([2, 3, 4]).should == CATransform3D.new(2,0,0,0, 0,3,0,0, 0,0,4,0, 0,0,0,1)
    end

  end

  describe ".translate" do

    it "should work as a factory with three arguments" do
      CATransform3D.translate(10, 20, 30).should == CATransform3D.new(1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,30,1)
    end

    it "should work as a factory with one array" do
      CATransform3D.translate([10, 20, 30]).should == CATransform3D.new(1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,30,1)
    end

    it "should work as a factory with a CGPoint" do
      CATransform3D.translate(CGPoint.new(10, 20)).should == CATransform3D.new(1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,0,1)
    end

    it "should work as an instance method with three arguments" do
      CATransform3D.identity.translate(10, 20, 30).should == CATransform3D.new(1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,30,1)
    end

    it "should work as an instance method with one array" do
      CATransform3D.identity.translate([10, 20, 30]).should == CATransform3D.new(1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,30,1)
    end

    it "should work as an instance method with a CGPoint" do
      CATransform3D.identity.translate(CGPoint.new(10, 20)).should == CATransform3D.new(1,0,0,0, 0,1,0,0, 0,0,1,0, 10,20,0,1)
    end

  end

  describe ".perspective" do

    it "should work as a factory with two arguments" do
      CATransform3D.perspective(0.002, 0).should == CATransform3D.new(1,0,0,0.002, 0,1,0,0, 0,0,1,0, 0,0,0,1)
      CATransform3D.perspective(0, 0.002).should == CATransform3D.new(1,0,0,0, 0,1,0,0.002, 0,0,1,0, 0,0,0,1)
    end

    it "should work as an instance method with two arguments" do
      CATransform3D.identity.perspective(0.002, 0).should == CATransform3D.new(1,0,0,0.002, 0,1,0,0, 0,0,1,0, 0,0,0,1)
      CATransform3D.identity.perspective(0, 0.002).should == CATransform3D.new(1,0,0,0, 0,1,0,0.002, 0,0,1,0, 0,0,0,1)
    end

  end

  describe "other methods" do

    it "should support concat" do
      t1 = CATransform3D.translate(10, 20, 30)
      t2 = CATransform3D.scale(2)
      t1.concat(t2).should == CATransform3D.new(2,0,0,0, 0,2,0,0, 0,0,1,0, 20,40,30,1)
    end

    it "should support invert" do
      t1 = CATransform3D.scale(2)
      t1.invert.should == CATransform3D.new(0.5,0,0,0, 0,0.5,0,0, 0,0,1,0, 0,0,0,1)
    end

    it "should support to_affine_transform" do
      t1 = CATransform3D.new(2,0,0,0, 0,2,0,0, 0,0,2,0, 0,0,0,1)
      t1.to_affine_transform.should == CGAffineTransformMake(2, 0, 0, 2, 0, 0)
    end

    it 'should support to_a' do
      t1 = CATransform3D.identity
      t1.to_a.should == [1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1]
    end

  end

  describe '#to/from_ns_value' do
    it 'should convert to NSValue' do
      val = CATransform3D.new(0.5,0,0,0, 0,0.5,0,0, 0,0,1,0, 0,0,0,1).to_ns_value
      val.should.be.kind_of(NSValue)
    end
    it 'should convert from NSValue' do
      val = NSValue.valueWithCATransform3D(CATransform3D.identity)
      transform = CATransform3D.from_ns_value(val)
      transform.should.be.kind_of(CATransform3D)
    end
  end

end
