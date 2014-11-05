class CGAffineTransform
  # CGAffineTransform.make  # default transform: identity matrix
  # # make a transform from scratch
  # CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
  #
  # # make a transform using primitives
  # CGAffineTransform.make(scale: 2, translate: [10, 10], rotate: Math::PI)
  def self.make(options = {})
    if options.key?(:a)
      args = [
        :a, :b,
        :c, :d,
        :tx, :ty,
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

  # Returns a transform that is translated. Accepts one or two arguments. One
  # argument can be a Point or Array with two items, two arguments should be the
  # x and y values.
  # @return CGAffineTransform
  def self.translate(point, ty=nil)
    if ty
      tx = point
    else
      tx = point[0]
      ty = point[1]
    end
    CGAffineTransformMakeTranslation(tx, ty)
  end

  # Returns a transform that is scaled. Accepts one or two arguments. One
  # argument can be a Point or Array with two items or a number that will be
  # used to scale both directions. Two arguments should be the x and y values.
  def self.scale(scale, sy=nil)
    if sy
      sx = scale
    elsif scale.is_a?(Numeric)
      sx = sy = scale
    else
      sx = scale[0]
      sy = scale[1]
    end
    CGAffineTransformMakeScale(sx, sy)
  end

  # Returns a transform that is rotated by `angle` (+ => counterclockwise, - => clockwise)
  # @return CGAffineTransform
  def self.rotate(angle)
    CGAffineTransformMakeRotation(angle)
  end

  # A "shear" translation turns a rectangle into a parallelogram
  # @param px [Numeric] how much to shear in x direction
  # @param py [Numeric] how much to shear in y direction
  # @return CGAffineTransform
  def self.shear(px, py)
    CGAffineTransformMake(1, py, px, 1, 0, 0)
  end

  # Returns the CGAffineTransform identity matrix
  # @return CGAffineTransform
  def self.identity
    CGAffineTransformIdentity
  end

  # Return true if the receiver is the identity matrix, false otherwise
  # @return CGAffineTransform
  def identity?
    CGAffineTransformIsIdentity(self)
  end

  # @return [CATransform3D]
  def to_transform3d
    CATransform3DMakeAffineTransform(self)
  end

  # @return [Boolean] true if the two matrices are equal
  def ==(transform)
    CGAffineTransformEqualToTransform(self, transform)
  end

  # Returns self
  # @return CGAffineTransform
  def +@
    self
  end

  # Concatenates the two transforms
  # @return CGAffineTransform
  def concat(transform)
    CGAffineTransformConcat(self, transform)
  end
  alias :+ :concat
  alias :<< :concat

  # Inverts the transform
  # @return CGAffineTransform
  def invert
    CGAffineTransformInvert(self)
  end
  alias :-@ :invert

  # Inverts the second transform and adds the result to `self`
  # @return CGAffineTransform
  def -(transform)
    self.concat transform.invert
  end

  # Applies a translation transform to the receiver
  # @return CGAffineTransform
  def translate(point, ty=nil)
    if ty
      tx = point
    else
      tx = point[0]
      ty = point[1]
    end
    CGAffineTransformTranslate(self, tx, ty)
  end

  # Applies a scale transform to the receiver
  # @return CGAffineTransform
  def scale(scale, sy=nil)
    if sy
      sx = scale
    elsif scale.is_a?(Numeric)
      sx = sy = scale
    else
      sx = scale[0]
      sy = scale[1]
    end
    CGAffineTransformScale(self, sx, sy)
  end

  # Applies a rotation transform to the receiver
  # @return CGAffineTransform
  def rotate(angle)
    CGAffineTransformRotate(self, angle)
  end

  # Applies a shear transform to the receiver
  # @return CGAffineTransform
  def shear(px, py)
    self.concat CGAffineTransform.shear(px, py)
  end

  def apply_to(thing)
    case thing
    when CGPoint
      CGPointApplyAffineTransform(thing, self)
    when CGSize
      CGSizeApplyAffineTransform(thing, self)
    when CGRect
      CGRectApplyAffineTransform(thing, self)
    else
      raise "Cannot apply transform to #{thing.inspect}"
    end
  end

  def to_a
    [self.a, self.b, self.c, self.d, self.tx, self.ty]
  end

  def to_ns_value
    NSValue.valueWithCGAffineTransform(self)
  end

  def self.from_ns_value(value)
    value.CGAffineTransformValue
  end

private
  def to_ary
    to_a
  end

end
