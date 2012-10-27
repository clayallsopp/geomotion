# Geomotion

iOS Geometry in idiomatic Ruby. Exhaustively tested. What's not to love?

## Features

### CGRect

```ruby
# Initializers
rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
another_way = CGRect.make(origin: CGPoint, size: CGSize)

# Getters
[rect.x, rect.y, rect.width, rect.height]
=> [10, 100, 50, 20]

rect_zero = CGRect.empty
=> CGRect(0, 0, 0, 0)
rect_zero.empty?
=> true

rect.center
=> CGPoint(25, 10) # center as bounds
rect.center(true)
=> CGPoint(35, 110) # center as frame

# Operator Overloading
rect + CGRect.make(x: 9, y: 99, width: 10, height: 10)
=> CGRect(9, 99, 50, 20) # == union of rects

rect + CGSize.new(11, 1)
=> CGRect(10, 100, 61, 21) # == increases the size, but keeps the origin

rect + CGPoint.new(10, 10)
=> CGRect.new(20, 110, 50, 20)

rect + UIOffsetMake(10, 10)
=> CGRect.new(20, 110, 50, 20)

a_point + a_size
=> CGRect # a point and a size make a rectangle. makes sense, right?

# Union and Intersection

rect.union_with CGRect.new(9, 99, 10, 10)
=> CGRect(9, 99, 50, 20)

rect.intersection_with CGRect.new(9, 99, 10, 10)
=> CGRect.new(10, 100, 10, 10)

# Growing and shrinking
# The center stays the same. Think margins!
rect.grow(CGSize.new(10, 20))
=> CGRect.new(5, 90, 60, 40)

rect.shrink(10)
=> CGRect.new(15, 105, 40, 10)

# Powerful layout adjustments with chainable methods
view = UIView.alloc.initWithFrame rect.below.width(100).height(10)
view.frame
=> CGRect(10, 120, 100, 10)

view2 = UIView.alloc.initWithFrame rect.beside(10)
view2.frame
=> CGRect(70, 100, 50, 20.0)

# More examples of adjustments
rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
[rect.right(20).x, rect.left(20).x, rect.up(20).y, rect.down(20).y]
=> [30, -10, 80, 120]

# Layout "above" and "before" rectangles
# (default offset is the rectangle's width or height)
rect.before(5)
=> CGRect.new(-45, 100, 50, 20)
rect.before(5, width:20)
=> CGRect.new(-15, 100, 20, 20)

rect.above(5)
=> CGRect.new(10, 75, 50, 20)
rect.above(5, height:10)
=> CGRect.new(10, 85, 50, 10)

# Layout a rect relative to others
rect2 = CGRect.make(x: 50, y: 50, width: 100, height: 100)
rect3 = CGRect.make(x:100, y: 200, width: 20, height: 20)

CGRect.layout(rect, above: rect2, right_of: rect3)
=> CGRect(120, 30, 50, 20)

# Also supports margins
CGRect.layout(rect, above: rect2, right_of: rect3, margins: [0, 0, 10, 15])
=> CGRect(135, 20, 50, 20)

```

### CGSize

```ruby
# Initializers
size = CGSize.make(width: 50, height: 20)

# Getters
size_zero = CGSize.empty
=> CGSize(0, 0)
size_zero.empty?
=> true

# Operator Overloading
size + CGSize.make(width: 100, height: 50)
=> CGSize(150, 70)

size + CGPoint.make(x: 10, y: 30)
=> CGRect(10, 30, 50, 20)

# Combine with CGPoint
size.rect_at_point CGPoint.make(x: 10, y: 30)
=> CGRect(10, 30, 50, 20)
```

### CGPoint

```ruby
# Initializers
point = CGPoint.make(x: 10, y: 100)

# Operator Overloading
point + CGPoint.make(x: 20, y: 40)
=> CGPoint(30, 140)

point + CGSize.make(width: 50, height: 20)
=> CGRect(10, 100, 50, 20)

# Combine with CGSize
point.rect_of_size CGSize.make(width: 50, height: 20)
=> CGRect(10, 100, 50, 20)

# Combine with CGRect
point.inside? CGRect.make(x: 0, y: 0, width: 20, height: 110)
=> true
```

## Install

1. `gem install geomotion`

2. Add `require 'geomotion'` in your `Rakefile`.


## Forking

If you have cool/better ideas, pull-request away!