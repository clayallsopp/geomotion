class CATransform3D
  # CATransform3D.make  # default transform: identity matrix
  # # make a transform from scratch. please don't ever do this ;-)
  # CATransform3D.make(
  #   m11: 1, m12: 0, m13: 0, m14: 0,
  #   m21: 0, m22: 1, m23: 0, m24: 0,
  #   m31: 0, m32: 0, m33: 1, m34: 0,
  #   m41: 0, m42: 0, m43: 0, m44: 1,
  # )
  #
  # # make a transform using primitives
  # CATransform3D.make(scale: 2, translate: [10, 10, 0], rotate: Math::PI)
  def self.make(options = {})
    if options[:m11]
      args = [
        :m11, :m12, :m13, :m14,
        :m21, :m22, :m23, :m24,
        :m31, :m32, :m33, :m34,
        :m41, :m42, :m43, :m44,
      ].map do |key|
        raise "#{key.inspect} is required" unless options.key? key
        options[key]
      end
      return self.new(*args)
    else
      retval = self.identity
      if options[:translate]
        retval = retval.translate(options[:translate])
      end
      if options[:scale]
        retval = retval.scale(options[:scale])
      end
      if options[:rotate]
        retval = retval.rotate(options[:rotate])
      end
      return retval
    end
  end

  # Returns a transform that is translated. Accepts one or three arguments. One
  # argument can be an Array with three numbers, three arguments should be the
  # x, y, z values.
  # @return [CATransform3D]
  def self.translate(point, ty=nil, tz=nil)
    if ty
      tx = point
    else
      tx = point[0]
      ty = point[1]
      tz = point[2]
    end
    CATransform3DMakeTranslation(tx, ty, tz)
  end

  # Returns a transform that is scaled. Accepts one or three arguments. One
  # argument can be an Array with three items or a number that will be used to
  # scale both x and y directions (z will be scale 1). Three arguments should be
  # the x, y, z values.
  def self.scale(scale, sy=nil, sz=nil)
    if sy
      sx = scale
    elsif scale.is_a?(Numeric)
      sx = sy = scale
      sz = 1
    else
      sx = scale[0]
      sy = scale[1]
      sz = scale[2]
    end
    CATransform3DMakeScale(sx, sy, sz)
  end

  # Returns a transform that is rotated by `angle` (+ => counterclockwise, - => clockwise)
  # @return [CATransform3D]
  def self.rotate(angle, point=nil, y=nil, z=nil)
    if point && y && z
      x = point
    elsif point
      x = point[0]
      y = point[1]
      z = point[2]
    else
      # default: spins around z-axis
      x = 0
      y = 0
      z = 1
    end
    CATransform3DMakeRotation(angle, x, y, z)
  end

  # A "shear" translation turns a rectangle into a parallelogram.  Delegates to
  # the CGAffineTransform with the same name
  # @param px [Numeric] how much to shear in x direction
  # @param py [Numeric] how much to shear in x direction
  # @return CATransform3D
  def self.shear(px, py)
    CGAffineTransform.shear(px, py).to_transform3d
  end

  # A perspective transform is a lot like a rotation... but different.  These
  # numbers should be very small, like 0.002 is a decent perspective shift.
  # @return CATransform3D
  def self.perspective(x, y)
    CATransform3D.new(1,0,0,x, 0,1,0,y, 0,0,1,0, 0,0,0,1)
  end

  # Returns the CATransform3D identity matrix
  # @return [CATransform3D]
  def self.identity
    CATransform3DMakeTranslation(0, 0, 0)
  end

  # Return true if the receiver is the identity matrix, false otherwise
  # @return [Boolean]
  def identity?
    CATransform3DIsIdentity(self)
  end

  # Return true if the receiver can be represented as an affine transform
  # @return [Boolean]
  def affine?
    CATransform3DIsAffine(self)
  end

  # @return [CGAffineTransform]
  def to_affine_transform
    CATransform3DGetAffineTransform(self)
  end

  # @return [Boolean] true if the two matrices are equal
  def ==(transform)
    CATransform3DEqualToTransform(self, transform)
  end

  # Returns self
  # @return [CATransform3D]
  def +@
    self
  end

  # Concatenates the two transforms
  # @return [CATransform3D]
  def concat(transform)
    CATransform3DConcat(self, transform)
  end
  alias :+ :concat
  alias :<< :concat

  # Inverts the transform
  # @return [CATransform3D]
  def invert
    CATransform3DInvert(self)
  end
  alias :-@ :invert

  # Inverts the second transform and adds the result to `self`
  # @return [CATransform3D]
  def -(transform)
    self.concat transform.invert
  end

  # Applies a translation transform to the receiver
  # @return [CATransform3D]
  def translate(point, ty=nil, tz=nil)
    if ty
      tx = point
    else
      tx = point[0]
      ty = point[1]
      tz = point[2]
    end
    CATransform3DTranslate(self, tx, ty, tz)
  end

  # Applies a scale transform to the receiver
  # @return [CATransform3D]
  def scale(scale, sy=nil, sz=nil)
    if sy
      sx = scale
    elsif scale.is_a?(Numeric)
      sx = sy = scale
      sz = 1
    else
      sx = scale[0]
      sy = scale[1]
      sz = scale[2]
    end
    CATransform3DScale(self, sx, sy, sz)
  end

  # Applies a rotation transform to the receiver
  # @return [CATransform3D]
  def rotate(angle, point=nil, y=nil, z=nil)
    if point && y && z
      x = point
    elsif point
      x = point[0]
      y = point[1]
      z = point[2]
    else
      # default: spins around z-axis
      x = 0
      y = 0
      z = 1
    end
    CATransform3DRotate(self, angle, x, y, z)
  end

  def shear(px, py)
    self.concat CGAffineTransform.shear(px, py).to_transform3d
  end

  # Applies a perspective transform to the receiver
  # @return CATransform3D
  def perspective(x, y)
    self.concat CATransform3D.perspective(x, y)
  end

  def to_a
    [self.m11, self.m12, self.m13, self.m14, self.m21, self.m22, self.m23, self.m24, self.m31, self.m32, self.m33, self.m34, self.m41, self.m42, self.m43, self.m44]
  end

end
