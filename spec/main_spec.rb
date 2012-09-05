describe "Application 'Geomotion'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should == 1
  end
end

describe "CGRect" do
  it ".below works" do
    rect = CGRect.make(x: 10, y: 100, width: 50, height: 20)
    rect.below(10).y.should == 130
  end
end