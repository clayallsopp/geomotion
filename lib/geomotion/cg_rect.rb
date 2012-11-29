class CGRect
  # CGRect.make(x: 10, y: 30)
  # CGRect.make(x: 10, y: 30, width:100, height: 20)
  def self.make(options = {})
    if options[:origin]
      options[:x] = options[:origin].x
      options[:y] = options[:origin].y
    end
    if options[:size]
      options[:width] = options[:size].width
      options[:height] = options[:size].height
    end
    CGRect.new([options[:x] || 0, options[:y] || 0], [options[:width] || 0, options[:height] || 0])
  end

  def self.empty
    # Don't return CGRectZero; can be mutated
    CGRect.make
  end

  def self.null
    CGRectNull
  end

  def self.infinite
    self.new([0, 0], CGSize.infinite)
  end

  # OPTIONS: [:above, :below, :left_of, :right_of, :margins]
  #   :margins is array of [top, right, bottom, left]
  # EX CGRect.layout(rect1, above: rect2, left_of: rect3, margins: [0, 10, 20, 0])
  def self.layout(rect1, options)
    if options.empty?
      p "No options provided in CGRect.layout"
      return rect1
    end

    rect = CGRect.new
    rect.size = rect1.size

    options[:margins] ||= []
    margins = {}
    [:top, :right, :bottom, :left].each_with_index do |margin, index|
      margins[margin] = options[:margins][index] || 0
    end

    rect.y = options[:above].up(rect.height + margins[:bottom]).y if options[:above]
    rect.y = options[:below].below(margins[:top]).y if options[:below]

    rect.x = options[:left_of].left(rect.width + margins[:right]).x if options[:left_of]
    rect.x = options[:right_of].beside(margins[:left]).x if options[:right_of]

    rect
  end

  def min_x
    CGRectGetMinX(self)
  end

  def max_x
    CGRectGetMaxX(self)
  end

  def min_y
    CGRectGetMinY(self)
  end

  def max_y
    CGRectGetMaxY(self)
  end

  def x(setter = nil)
    if setter
      return CGRect.new([setter, self.y], self.size)
    end
    min_x
  end

  def x=(_x)
    self.origin.x = _x
  end

  def y(setter = nil)
    if setter
      return CGRect.new([self.x, setter], self.size)
    end
    min_y
  end

  def y=(_y)
    self.origin.y = _y
  end

  def width(setter = nil)
    if setter
      return CGRect.new(self.origin, [setter, self.height])
    end
    CGRectGetWidth(self)
  end

  def width=(_width)
    self.size.width = _width
  end

  def height(setter = nil)
    if setter
      return CGRect.new(self.origin, [self.width, setter])
    end
    CGRectGetHeight(self)
  end

  def height=(_height)
    self.size.height = _height
  end

  def left(dist = 0)
    CGRect.new([self.x - dist, self.y], self.size)
  end

  def right(dist = 0)
    CGRect.new([self.x + dist, self.y], self.size)
  end

  def up(dist = 0)
    CGRect.new([self.x, self.y - dist], self.size)
  end

  def down(dist = 0)
    CGRect.new([self.x, self.y + dist], self.size)
  end

  def above(margin = 0)
    self.above(margin, height:self.height)
  end

  def above(margin, height:height)
    CGRect.new([self.x, self.y - height - margin], [self.width, height])
  end

  def below(margin = 0)
    CGRect.new([self.x, self.y + self.height + margin], self.size)
  end

  def before(margin = 0)
    self.before(margin, width:self.width)
  end

  def before(margin, width:width)
    CGRect.new([self.x - width - margin, self.y], [width, self.height])
  end

  def beside(margin = 0)
    CGRect.new([self.x + self.width + margin, self.y], self.size)
  end

  def center(relative = false)
    offset_x = relative ? self.x : 0
    offset_y = relative ? self.y : 0
    CGPoint.new(offset_x + self.width / 2, offset_y + self.height / 2)
  end

  def round
    CGRect.new([self.x.round, self.y.round], [self.width.round, self.height.round])
  end

  def centered_in(rect, relative = false)
    offset_x = relative ? rect.x : 0
    offset_y = relative ? rect.y : 0
    CGRect.new([offset_x + ((rect.width - self.width) / 2),
                offset_y + ((rect.height - self.height) / 2)], self.size)
  end

  def +(other)
    case other
    when CGRect
      return self.union_with(other)
    when CGSize
      return CGRect.new([self.x, self.y], [self.width + other.width, self.height + other.height])
    when CGPoint
      return CGRectOffset(self, other.x, other.y)
    when UIOffset
      CGRectOffset(self, other.horizontal, other.vertical)
    when UIEdgeInsets
      UIEdgeInsetsInsetRect(self, other)
    end
  end

  def intersection_with(rect)
    CGRectIntersection(self, rect)
  end

  def union_with(rect)
    CGRectUnion(self, rect)
  end

  def grow(size)
    if size.is_a? Numeric
      size = CGSize.new(size, size)
    end
    CGRectInset(self, -size.width, -size.height)
  end

  def shrink(size)
    if size.is_a? Numeric
      size = CGSize.new(size, size)
    end
    CGRectInset(self, size.width, size.height)
  end

  def empty?
    CGRectIsEmpty(self)
  end

  def infinite?
    self.size.infinite?
  end

  def null?
    CGRectIsNull(self)
  end

  def intersects?(rect)
    case rect
    when CGRect
      CGRectIntersectsRect(self, rect)
    else
      super
    end
  end

  def contains?(rect_or_point)
    case rect_or_point
    when CGPoint
      CGRectContainsPoint(self, rect_or_point)
    when CGRect
      CGRectContainsRect(self, rect_or_point)
    else
      super
    end
  end

  def ==(rect)
    rect.is_a?(CGRect) && CGRectEqualToRect(self, rect)
  end

  def -@
    CGRect.new(-self.origin, -self.size)
  end

  def -(other)
    self.+(-other)
  end

  def inspect
    "#{self.class.name}([#{self.origin.x}, #{self.origin.y}], [#{self.size.width}, #{self.size.height}])"
  end

end
