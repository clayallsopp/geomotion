# Geomotion

iOS geometry is too verbose for Ruby. Geomotion tries to fix that.

## Usage

```ruby
# More idiomatic initializers
rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
size = CGSize.make(width: 50, height: 20)
point = CGPoint.make(x: 10, y: 100)

# these will all create the same rect:
rect = CGRect.make(origin: point, size: size)
rect = size.rect_at_point(point)
rect = point.rect_of_size(size)
rect = point + size
rect = size + point  # => CGRect.new(point, size)

# points are treated as a vector
offset = CGPoint.new(10, 10)
point + offset  # => CGPoint.new(20, 110)
rect1 + offset  # => CGRect.new([20, 110], [50, 20])
# or you can use an actual "UIOffset" object
offset = UIOffset.new(10, 10)
point + offset
rect1 + offset

# adding a size to a size or rect increases the size, but keeps the origin
bigger = CGSize.new(11, 1)
size + bigger  # => CGSize.new(61, 21)
rect + bigger  # => CGRect.new([10, 100], [61, 21])

# adding two rects creates a union of the two (a rect big enough to contain both)
rect + CGRect.new(9, 99, 10, 10)  # => CGRect.new(9, 99, 50, 20)
# same as
rect.union(CGRect.new(9, 99, 10, 10))
# intersections:
rect.intersect(CGRect.new(9, 99, 10, 10))  # => CGRect.new(10, 100, 10, 10)

# grow or shrink a rect by a size.  the center stays the same.  think margins!
rect.grow(CGSize.new(10, 20))  # => CGRect.new(5, 90, 60, 40)
rect.shrink(10)  # => CGRect.new(15, 105, 40, 10)

# These do what you think
[rect.x, rect.y, rect.width, rect.height]
=> [10, 100, 50, 20]

# Chainable methods for adjusting frames
view = UIView.alloc.initWithFrame rect.below.width(100).height(10)
view.frame
=> #<CGRect origin=#<CGPoint x=10.0 y=120.0> size=#<CGSize width=100.0 height=10.0>>

view2 = UIView.alloc.initWithFrame rect.beside(10)
view2.frame
=> #<CGRect origin=#<CGPoint x=70.0 y=100.0> size=#<CGSize width=50.0 height=20.0>>

[rect.right(20).x, rect.left(20).x, rect.up(20).y, rect.down(20).y]
=> [30, -10, 80, 120]

# you can also do "above" and "before" rects, but these require a width or height up front
# (default is the current width or height)
rect.before(5)  # => CGRect.new(-45, 100, 50, 20)
rect.before(5, width:20)  # => CGRect.new(-15, 100, 20, 20)

rect.above(5) # => CGRect.new(10, 75, 50, 20)
rect.above(5, height:10) # => CGRect.new(10, 85, 50, 10)

# Layout a rect relative to others
rect2 = CGRect.new [50, 50], [100, 100]
rect3 = CGRect.new [100, 200], [20, 20]

CGRect.layout(rect, above: rect2, right_of: rect3)
=> #<CGRect origin=#<CGPoint x=120.0 y=30.0> size=#<CGSize width=50.0 height=20.0>>

# Also supports margins
CGRect.layout(rect, above: rect2, right_of: rect3, margins: [0, 0, 10, 15])
=> #<CGRect origin=#<CGPoint x=135.0 y=20.0> size=#<CGSize width=50.0 height=20.0>>
```

## Install

1. `gem install geomotion`

2. Add `require geomotion` in your `Rakefile`.


## Forking

If you have cool/better ideas, pull-request away!