class CGSize
  # CGSize.make(width: 10, height: 30)
  def self.make(options = {})
    CGSize.new(options[:width] || 0, options[:height] || 0)
  end

  def self.infinite
    infinity = CGRect.null[0][0]
    CGSizeMake(infinity, infinity)
  end

  # size = CGSize.make width: 100, height: 100
  # point = CPPoint.make x:0, y:10
  # size.rect_at_point(point)  # => CGRect([0, 10], [100, 100])
  # size.rect_at_point([10, 20])  # => CGRect([10, 20], [100, 100])
  def rect_at_point(point)
    CGRect.new(point, [self.width, self.height])
  end

  def +(other)
    case other
    when CGSize
      return CGSize.new(self.width + other.width, self.height + other.height)
    when CGPoint
      return self.rect_at_point(other)
    end
  end

  def infinite?
    infinity = CGRect.null[0][0]  # null rects are rects with infinite width & height
    self.width == infinity or self.height == infinity
  end

  def empty?
    self == CGSizeZero
  end

  def ==(size)
    size.is_a?(CGSize) && CGSizeEqualToSize(self, size)
  end
end
