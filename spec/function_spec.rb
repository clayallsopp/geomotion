describe "Functions" do
  describe "CGRect" do
    it "should work with one array" do
      rect = CGRect([[0, 0], [0, 0]])
      rect.should.be.kind_of(CGRect)
    end
    it "should work with two arrays" do
      rect = CGRect([0, 0], [0, 0])
      rect.should.be.kind_of(CGRect)
    end
    it "should work with four numbers" do
      rect = CGRect(0, 0, 0, 0)
      rect.should.be.kind_of(CGRect)
    end
    it "should work with .make" do
      rect = CGRect(x: 0, y: 0, w: 0, h: 0)
      rect.should.be.kind_of(CGRect)
    end
  end
  describe "CGSize" do
    it "should work with one array" do
      size = CGSize([0, 0])
      size.should.be.kind_of(CGSize)
    end
    it "should work with two numbers" do
      size = CGSize(0, 0)
      size.should.be.kind_of(CGSize)
    end
    it "should work with .make" do
      size = CGSize(w: 0, h: 0)
      size.should.be.kind_of(CGSize)
    end
  end
  describe "CGPoint" do
    it "should work with one array" do
      point = CGPoint([0, 0])
      point.should.be.kind_of(CGPoint)
    end
    it "should work with two numbers" do
      point = CGPoint(0, 0)
      point.should.be.kind_of(CGPoint)
    end
    it "should work with .make" do
      point = CGPoint(x: 0, y: 0)
      point.should.be.kind_of(CGPoint)
    end
  end
  describe "CGAffineTransform" do
    it "should work with all numbers" do
      transform = CGAffineTransform(1, 0, 0, 1, 0, 0)
      transform.should.be.kind_of(CGAffineTransform)
    end
    it "should work with one array" do
      transform = CGAffineTransform([1, 0, 0, 1, 0, 0])
      transform.should.be.kind_of(CGAffineTransform)
    end
    it "should work with .make" do
      transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
      transform.should.be.kind_of(CGAffineTransform)
    end
  end
  describe "CATransform3D" do
    it "should work with all numbers" do
      transform = CATransform3D(
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
      )
      transform.should.be.kind_of(CATransform3D)
    end
    it "should work with one array" do
      transform = CATransform3D([
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
      ])
      transform.should.be.kind_of(CATransform3D)
    end
    it "should work with .make" do
      transform = CATransform3D(
        m11: 1, m12: 0, m13: 0, m14: 0,
        m21: 0, m22: 1, m23: 0, m24: 0,
        m31: 0, m32: 0, m33: 1, m34: 0,
        m41: 0, m42: 0, m43: 0, m44: 1,
      )
      transform.should.be.kind_of(CATransform3D)
    end
  end
end
