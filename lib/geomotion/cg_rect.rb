class CGRect
  # CGRect.make(x: 10, y: 30)
  def self.make(options = {})
    CGRect.new([options[:x] || 0, options[:y] || 0], [options[:width] || 0, options[:height] || 0])
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

    rect.y = options[:above].up(rect.height + margins[:bottom]) if options[:above]
    rect.y = options[:below].below(rect.height + margins[:top]) if options[:below]

    rect.x = options[:left_of].left(rect.width + margins[:right]) if options[:left_of]
    rect.x = options[:right_of].beside(rect.width + margins[:left]) if options[:right_of]

    rect
  end

  def x(setter = nil)
    self.x = setter if setter
    self.origin.x
  end

  def x=(_x)
    self.origin.x = _x
  end

  def y(setter = nil)
    self.y = setter if setter
    self.origin.y
  end

  def y=(_y)
    self.origin.y = _y
  end

  def width(setter = nil)
    self.width = setter if setter
    self.size.width
  end

  def width=(_width)
    self.size.width = _width
  end

  def height(setter = nil)
    self.height = setter if setter
    self.size.height
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
    CGRect.new([self.x, self.y - up], self.size)
  end

  def down(dist = 0)
    CGRect.new([self.x, self.y + dist], self.size)
  end

  def below(margin = 0)
    CGRect.new([self.x, self.y + self.height + dist], self.size)
  end

  def beside(margin = 0)
    CGRect.new([self.x + self.width + margin, self.y], self.size)
  end

  def center(relative = false)
    offset_x = relative ? self.x : 0
    offset_y = relative ? self.y : 0
    CGPoint.new(offset_x + self.width / 2, offset_y = self.height / 2)
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
end