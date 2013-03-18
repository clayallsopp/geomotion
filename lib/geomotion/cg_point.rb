class CGPoint
  # CGPoint.make(x: 10, y: 30)
  def self.make(options = {})
    CGPoint.new(options[:x] || 0, options[:y] || 0)
  end

  # size = CGSize.make width: 100, height: 100
  # point = CPPoint.make x:0, y:10
  # point.rect_of_size(size)  # => CGRect([0, 10], [100, 100])
  # point.rect_of_size([10, 20])  # => CGRect([10, 20], [100, 100])
  def rect_of_size(size)
    CGRect.new([self.x, self.y], size)
  end

  # modified points
  def left(dist = 0)
    CGPoint.new(self.x - dist, self.y)
  end

  def right(dist = 0)
    CGPoint.new(self.x + dist, self.y)
  end

  def up(dist = 0)
    CGPoint.new(self.x, self.y - dist)
  end

  def down(dist = 0)
    CGPoint.new(self.x, self.y + dist)
  end

  def round
    CGPoint.new(self.x.round, self.y.round)
  end

  def inside?(rect)
    CGRectContainsPoint(rect, self)
  end

  def distance_to(point)
    dx = self.x - point.x
    dy = self.y - point.y
    return Math.sqrt(dx**2 + dy**2)
  end

  def angle_to(point)
    dx = point.x - self.x
    dy = point.y - self.y
    return Math.atan2(dy, dx)
  end

  # operator
  def +(other)
    case other
    when CGSize
      return self.rect_of_size(other)
    when CGPoint
      return CGPoint.new(self.x + other.x, self.y + other.y)
    end
  end

  def *(scale)
    case scale
    when Numeric
      return CGPoint.new(self.x * scale, self.y * scale)
    else
      super
    end
  end

  # it is tempting to define this as self * (1.0/scale) but floating point
  # errors result in too many errors
  def /(scale)
    case scale
    when Numeric
      return CGPoint.new(self.x / scale, self.y / scale)
    else
      super
    end
  end

  def ==(point)
    point.is_a?(CGPoint) && CGPointEqualToPoint(self, point)
  end

  def -@
    CGPoint.new(-self.x, -self.y)
  end

  def -(other)
    self.+(-other)
  end

  def inspect
    "#{self.class.name}(#{self.x}, #{self.y})"
  end

end
