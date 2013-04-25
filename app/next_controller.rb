class ShowNextController < UIViewController

  def init
    super.tap do
      if next_controller
        navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle('Next', style:UIBarButtonItemStylePlain, target:self, action: :show_next)
      end
    end
  end

  def show_next
    navigationController.pushViewController(next_controller, animated:true)
  end

  def next_controller
    nil
  end

end
