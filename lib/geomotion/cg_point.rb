class CGPoint
  # CGPoint.make(x: 10, y: 30)
  def self.make(options = {})
    CGPoint.new(options[:x] || 0, options[:y] || 0)
  end

  # size = CGSize.make width: 100, height: 100
  # point = CPPoint.make x:0, y:10
  # point.rect_of_size(point)  # => CGRect([0, 10], [100, 100])
  # point.rect_of_size([10, 20])  # => CGRect([10, 20], [100, 100])
  def rect_of_size(size)
    CGRect.new([self.x, self.y], size)
  end

  def +(other)
    case other
    when CGSize
      return self.rect_of_size(other)
    when CGPoint
      return CGPoint.new(self.x + other.x, self.y + other.y)
    end
  end

  def round
    CGPoint.new(self.x.round, self.y.round)
  end

  def inside?(rect)
    CGRectContainsPoint(rect, self)
  end

  def ==(point)
    point.is_a?(CGPoint) && CGPointEqualToPoint(self, point)
  end

end
