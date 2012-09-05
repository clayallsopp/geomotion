# Geomotion

iOS geometry is too verbose for Ruby. Geomotion tries to fix that.

## Usage

```ruby
# More idiomatic initializer
rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)

# These do what you think
[rect.x, rect.y, rect.width, rect.height]
=> [10, 100, 50, 20]

# Chainable methods for adjusting frames
view = UIView.alloc.initWithFrame rect.below(10).width(100).height(10)
view.frame
=> #<CGRect origin=#<CGPoint x=10.0 y=130.0> size=#<CGSize width=100.0 height=10.0>>

view2 = UIView.alloc.initWithFrame rect.beside(10)
view2.frame
=> #<CGRect origin=#<CGPoint x=70.0 y=100.0> size=#<CGSize width=50.0 height=20.0>>

[rect.right(20).x, rect.left(20).x, rect.up(20).y, rect.down(20).y]
=> [30, -10, 80, 120]

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