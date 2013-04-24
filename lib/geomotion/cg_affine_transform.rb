class CGAffineTransform
  # CGAffineTransform.make  # default transform: identity matrix
  # # make a transform from scratch
  # CGAffineTransform.make(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
  #
  # # make a transform using primitives
  # CGAffineTransform.make(scale: 2, translate: [10, 10], rotate: Math::PI)
  def self.make(options = {})
    if options[:a]
      a = options[:a]
      raise "`:a` is required" unless a
      b = options[:b]
      raise "`:b` is required" unless b
      c = options[:c]
      raise "`:c` is required" unless c
      d = options[:d]
      raise "`:d` is required" unless d
      tx = options[:tx]
      raise "`:tx` is required" unless tx
      ty = options[:ty]
      raise "`:ty` is required" unless ty
      return self.new(a, b, c, d, tx, ty)
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
  def self.translate(point, y=nil)
    if y
      x = point
    elsif point.is_a?(Numeric)
      x = y = point
    else
      x = point[0]
      y = point[1]
    end
    CGAffineTransformMakeTranslation(x, y)
  end

  # Returns a transform that is scaled. Accepts one or two arguments. One
  # argument can be a Point or Array with two items, two arguments should be the
  # x and y values.
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
  def +(transform)
    CGAffineTransformConcat(self, transform)
  end

  # Concatenates the two transforms
  # @return CGAffineTransform
  def <<(transform)
    CGAffineTransformConcat(self, transform)
  end

  # Inverts the transform
  # @return CGAffineTransform
  def -@
    CGAffineTransformInvert(self)
  end

  # Inverts the second transform and adds the result to `self`
  # @return CGAffineTransform
  def -(transform)
    self + -transform
  end

  # Applies a translation transform to the receiver
  # @return CGAffineTransform
  def translate(point, y=nil)
    if y
      x = point
    elsif point.is_a?(Numeric)
      x = y = point
    else
      x = point[0]
      y = point[1]
    end
    CGAffineTransformTranslate(self, x, y)
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

end
