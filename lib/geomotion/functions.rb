def CGRect(*args)
  if args.length == 1 && args[0].is_a?(Hash)
    CGRect.make(args[0])
  elsif args.length == 1
    CGRect.new(*args[0])
  elsif args.length == 4
    CGRect.new([args[0], args[1]], [args[2], args[3]])
  else
    CGRect.new(*args)
  end
end


def CGSize(*args)
  if args.length == 1 && args[0].is_a?(Hash)
    CGSize.make(args[0])
  elsif args.length == 1
    CGSize.new(*args[0])
  else
    CGSize.new(*args)
  end
end


def CGPoint(*args)
  if args.length == 1 && args[0].is_a?(Hash)
    CGPoint.make(args[0])
  elsif args.length == 1
    CGPoint.new(*args[0])
  else
    CGPoint.new(*args)
  end
end


def CGAffineTransform(*args)
  if args.length == 1 && args[0].is_a?(Hash)
    CGAffineTransform.make(args[0])
  elsif args.length == 1
    CGAffineTransform.new(*args[0])
  else
    CGAffineTransform.new(*args)
  end
end


def CATransform3D(*args)
  if args.length == 1 && args[0].is_a?(Hash)
    CATransform3D.make(args[0])
  elsif args.length == 1
    CATransform3D.new(*args[0])
  else
    CATransform3D.new(*args)
  end
end
