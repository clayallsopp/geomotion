class CGRect

  class << self
    # CGRect.make  # default rect: {origin: {x: 0, y: 0}, size: {width:0, height:0}}
    #              # aka CGRectZero
    # CGRect.make(x: 10, y: 30)  # default size: [0, 0]
    # CGRect.make(x: 10, y: 30, width:100, height: 20)
    #
    # point = CGPoint.make(x: 10, y: 30)
    # size = CGSize.make(width: 100, height: 20)
    # CGRect.make(origin: point, size: size)
    def make(options = {})
      if options[:origin]
        x = options[:origin][0]
        y = options[:origin][1]
      else
        x = options[:x] || 0
        y = options[:y] || 0
      end
      if options[:size]
        w = options[:size][0]
        h = options[:size][1]
      else
        w = options[:width] || 0
        h = options[:height] || 0
      end
      self.new([x, y], [w, h])
    end

    def zero
      CGRect.new([0, 0], [0, 0])
    end
    alias empty zero

    def null
      # Don't just return CGRectNull; can be mutated
      CGRect.new([Float::INFINITY, Float::INFINITY], [0, 0])
    end

    def infinite
      # This actually returns the not-very-infinite value of:
      # [[-1.7014114289565e+38, -1.7014114289565e+38], [3.402822857913e+38, 3.402822857913e+38]]
      # originally this method returned [[-Infinity, -Infinity], [Infinity, Infinity]],
      # but that rect ended up returning `false` for any point in the method
      # CGRect.infinite.contains?(point).  CGRectInfinite returns `true` for any
      # (sensible) point, so we'll go with that instead
      CGRectInfinite.dup
    end

    # OPTIONS: [:above, :below, :left_of, :right_of, :margins]
    #   :margins is array of [top, right, bottom, left]
    # EX CGRect.layout(rect1, above: rect2, left_of: rect3, margins: [0, 10, 20, 0])
    def layout(rect1, options)
      if options.empty?
        p "No options provided in #{self.class}.layout"
        return rect1
      end

      rect = self.new
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

  end

  # bounds
  def min_x
    CGRectGetMinX(self)
  end

  def mid_x
    CGRectGetMidX(self)
  end

  def max_x
    CGRectGetMaxX(self)
  end

  def min_y
    CGRectGetMinY(self)
  end

  def mid_y
    CGRectGetMidY(self)
  end

  def max_y
    CGRectGetMaxY(self)
  end

  # getters/setters
  def x(setter = nil)
    if setter
      return CGRect.new([setter, self.origin.y], self.size)
    end
    min_x
  end

  def x=(_x)
    self.origin.x = _x
  end

  def y(setter = nil)
    if setter
      return CGRect.new([self.origin.x, setter], self.size)
    end
    min_y
  end

  def y=(_y)
    self.origin.y = _y
  end

  def width(setter = nil)
    if setter
      return CGRect.new(self.origin, [setter, self.size.height])
    end
    CGRectGetWidth(self)
  end

  def width=(_width)
    self.size.width = _width
  end

  def height(setter = nil)
    if setter
      return CGRect.new(self.origin, [self.size.width, setter])
    end
    CGRectGetHeight(self)
  end

  def height=(_height)
    self.size.height = _height
  end

  # most rect modifiers call this method in one way or another
  def apply(options)
    rect = CGRectStandardize(CGRect.new(self.origin, self.size))
    options.each do |method, value|
      case method
      when :left
        rect.origin.x -= value
      when :right
        rect.origin.x += value
      when :up
        rect.origin.y -= value
      when :down
        rect.origin.y += value
      when :wider, :grow_right
        rect.size.width += value
      when :thinner, :shrink_left
        rect.size.width -= value
      when :taller, :grow_down
        rect.size.height += value
      when :shorter, :shrink_up
        rect.size.height -= value
      when :x
        rect.origin.x = value
      when :y
        rect.origin.y = value
      when :origin
        rect.origin = value
      when :width
        rect.size.width = value
      when :height
        rect.size.height = value
      when :size
        rect.size = value
      when :grow
        rect = rect.grow(value)
      when :grow_up
        rect.size.height += value
        rect.origin.y -= value
      when :shrink_down
        rect.size.height -= value
        rect.origin.y += value
      when :grow_left
        rect.size.width += value
        rect.origin.x -= value
      when :shrink_right
        rect.size.width -= value
        rect.origin.x += value
      when :grow_width
        rect = rect.grow_width(value)
      when :grow_height
        rect = rect.grow_height(value)
      when :shrink
        rect = rect.shrink(value)
      when :shrink_width
        rect = rect.shrink_width(value)
      when :shrink_height
        rect = rect.shrink_height(value)
      when :offset
        rect = rect.offset(value)
      else
        raise "Unknow option #{method}"
      end
    end
    return rect
  end

  # modified rects
  def left(dist=nil, options={})
    if dist.nil?
      NSLog("Using the default value of `0` in `CGRect#left` is deprecated.")
      dist = 0
    end
    raise "You must specify an amount in `CGRect#left`" unless dist.is_a?(Numeric)

    options[:left] = dist
    self.apply(options)
  end

  def right(dist=nil, options={})
    if dist.nil?
      NSLog("Using the default value of `0` in `CGRect#right` is deprecated.")
      dist = 0
    end
    raise "You must specify an amount in `CGRect#right`" unless dist.is_a?(Numeric)

    options[:right] = dist
    self.apply(options)
  end

  def up(dist=nil, options={})
    if dist.nil?
      NSLog("Using the default value of `0` in `CGRect#up` is deprecated.")
      dist = 0
    end
    raise "You must specify an amount in `CGRect#up`" unless dist.is_a?(Numeric)

    options[:up] = dist
    self.apply(options)
  end

  def down(dist=nil, options={})
    if dist.nil?
      NSLog("Using the default value of `0` in `CGRect#down` is deprecated.")
      dist = 0
    end
    raise "You must specify an amount in `CGRect#down`" unless dist.is_a?(Numeric)

    options[:down] = dist
    self.apply(options)
  end

  def wider(dist, options={})
    raise "You must specify an amount in `CGRect#wider`" unless dist.is_a?(Numeric)

    options[:wider] = dist
    self.apply(options)
  end

  def thinner(dist, options={})
    raise "You must specify an amount in `CGRect#thinner`" unless dist.is_a?(Numeric)

    options[:thinner] = dist
    self.apply(options)
  end

  def taller(dist, options={})
    raise "You must specify an amount in `CGRect#taller`" unless dist.is_a?(Numeric)

    options[:taller] = dist
    self.apply(options)
  end

  def shorter(dist, options={})
    raise "You must specify an amount in `CGRect#shorter`" unless dist.is_a?(Numeric)

    options[:shorter] = dist
    self.apply(options)
  end

  # adjacent rects
  def above(margin = 0, options={})
    margin, options = 0, margin if margin.is_a?(NSDictionary)

    height = options[:height] || self.size.height
    options[:up] = height + margin
    self.apply(options)
  end

  def below(margin = 0, options={})
    margin, options = 0, margin if margin.is_a?(NSDictionary)

    options[:down] = self.size.height + margin
    self.apply(options)
  end

  def before(margin = 0, options={})
    margin, options = 0, margin if margin.is_a?(NSDictionary)

    width = options[:width] || self.size.width
    options[:left] = width + margin
    self.apply(options)
  end

  def beside(margin = 0, options={})
    margin, options = 0, margin if margin.is_a?(NSDictionary)

    options[:right] = self.size.width + margin
    self.apply(options)
  end

  # positions
private
  def cgrect_offset(absolute)
    if absolute
      CGPoint.new(self.min_x, self.min_y)
    else
      CGPoint.new(0, 0)
    end
  end

public
  def center(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(self.size.width / 2, self.size.height / 2)
  end

  def top_left(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(0, 0)
  end

  def top_center(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(self.size.width / 2, 0)
  end

  def top_right(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(self.size.width, 0)
  end

  def center_right(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(self.size.width, self.size.height / 2)
  end

  def bottom_right(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(self.size.width, self.size.height)
  end

  def bottom_center(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(self.size.width / 2, self.size.height)
  end

  def bottom_left(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(0, self.size.height)
  end

  def center_left(absolute = false)
    cgrect_offset(absolute) + CGPoint.new(0, self.size.height / 2)
  end

  # others
  def round
    CGRect.new([self.origin.x.round, self.origin.y.round], [self.size.width.round, self.size.height.round])
  end

  def centered_in(rect, absolute = false)
    self.size.centered_in(rect, absolute)
  end

  def +(other)
    case other
    when CGRect
      return self.union_with(other)
    when CGSize
      return CGRect.new([self.origin.x, self.origin.y], [self.size.width + other.width, self.size.height + other.height])
    when CGPoint
      return self.offset(other.x, other.y)
    when UIOffset
      return self.offset(other.horizontal, other.vertical)
    when UIEdgeInsets
      return self.inset(other)
    end
  end

  def *(scale)
    case scale
    when Numeric
      return CGRect.new(self.origin, self.size * scale)
    else
      super
    end
  end

  # it is tempting to define this as self * (1.0/scale) but floating point
  # errors result in too many errors
  def /(scale)
    case scale
    when Numeric
      return CGRect.new(self.origin, self.size / scale)
    else
      super
    end
  end

  def intersection_with(rect)
    CGRectIntersection(self, rect)
  end

  def union_with(rect)
    CGRectUnion(self, rect)
  end

  def inset(insets)
    UIEdgeInsetsInsetRect(self, insets)
  end

  def offset(point_or_x, y=nil)
    if y
      CGRectOffset(self, point_or_x, y)
    else
      CGRectOffset(self, point_or_x[0], point_or_x[1])
    end
  end

  def grow(size, options=nil)
    if size.is_a? Numeric
      size = CGSize.new(size, size)
    end
    rect = CGRectInset(self, -size[0], -size[1])
    if options
      return rect.apply(options)
    end
    return rect
  end

  alias grow_right wider
  def grow_left(amount, options=nil)
    raise "You must specify an amount in `CGRect#grow_left`" unless amount.is_a?(Numeric)

    options[:grow_left] = amount
    self.apply(options)
  end

  alias grow_down taller
  def grow_up(amount, options=nil)
    raise "You must specify an amount in `CGRect#grow_up`" unless amount.is_a?(Numeric)

    options[:grow_up] = amount
    self.apply(options)
  end

  def grow_width(amount, options=nil)
    return self.grow([amount, 0], options)
  end

  def grow_height(amount, options=nil)
    return self.grow([0, amount], options)
  end

  def shrink(size, options=nil)
    if size.is_a? Numeric
      size = CGSize.new(size, size)
    end
    rect = CGRectInset(self, size[0], size[1])
    if options
      return rect.apply(options)
    end
    return rect
  end

  alias shrink_left thinner
  def shrink_right(amount, options={})
    raise "You must specify an amount in `CGRect#shrink_right`" unless amount.is_a?(Numeric)

    options[:shrink_right] = amount
    self.apply(options)
  end

  alias shrink_up shorter
  def shrink_down(amount, options={})
    raise "You must specify an amount in `CGRect#shrink_down`" unless amount.is_a?(Numeric)

    options[:shrink_down] = amount
    self.apply(options)
  end

  def shrink_width(amount, options={})
    return self.shrink([amount, 0], options)
  end

  def shrink_height(amount, options={})
    return self.shrink([0, amount], options)
  end

  def empty?
    CGRectIsEmpty(self)
  end

  def infinite?
    self.size.infinite? || CGRectEqualToRect(self, CGRectInfinite)
  end

  def null?
    CGRectIsNull(self)
  end

  def intersects?(rect)
    case rect
    when CGRect
      CGRectIntersectsRect(self, rect)
    else
      super  # raises an error
    end
  end

  def contains?(rect_or_point)
    case rect_or_point
    when CGPoint
      CGRectContainsPoint(self, rect_or_point)
    when CGRect
      CGRectContainsRect(self, rect_or_point)
    else
      super  # raises an error
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
