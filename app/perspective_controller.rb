class PerspectiveController < UIViewController

  def viewDidLoad
    self.title = 'Perspective'

    @restore = {
      red: false, green: false, blue: false,
    }
    red = UIButton.buttonWithType(UIButtonTypeCustom)
    red.setTitle('0.004, 0', forState: UIControlStateNormal)
    red.backgroundColor = UIColor.redColor
    red.frame = [[80, 16], [160, 100]]
    red.addTarget(self, action: :transform_red, forControlEvents:UIControlEventTouchUpInside)

    green = UIButton.buttonWithType(UIButtonTypeCustom)
    green.setTitle('0, 0.004', forState: UIControlStateNormal)
    green.backgroundColor = UIColor.greenColor
    green.frame = red.frame.below(30)
    green.addTarget(self, action: :transform_green, forControlEvents:UIControlEventTouchUpInside)

    blue = UIButton.buttonWithType(UIButtonTypeCustom)
    blue.setTitle("0.004, 0.004", forState: UIControlStateNormal)
    blue.backgroundColor = UIColor.blueColor
    blue.frame = green.frame.below(30)
    blue.addTarget(self, action: :transform_blue, forControlEvents:UIControlEventTouchUpInside)

    self.view.addSubview(@red = red)
    self.view.addSubview(@green = green)
    self.view.addSubview(@blue = blue)
  end

  def animate(&block)
    UIView.animateWithDuration(0.3,
      delay:0,
      options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState,
      animations:block,
      completion:nil)
  end

  def transform_red
    animate do
      if @restore[:red]
        @red.layer.transform = CATransform3D.identity
      else
        @red.layer.transform = CATransform3D.perspective(0.004, 0)
      end
      @restore[:red] = ! @restore[:red]
    end
  end

  def transform_green
    animate do
      if @restore[:green]
        @green.layer.transform = CATransform3D.identity
      else
        @green.layer.transform = CATransform3D.perspective(0, 0.004)
      end
      @restore[:green] = ! @restore[:green]
    end
  end

  def transform_blue
    animate do
      if @restore[:blue]
        @blue.layer.transform = CATransform3D.identity
      else
        @blue.layer.transform = CATransform3D.perspective(0.004, 0.004)
      end
      @restore[:blue] = ! @restore[:blue]
    end
  end

  def next_controller
  end

end
