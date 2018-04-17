class Abstract
  def abstract?
    @__abstract__
  end

  def method_missing(method)
    return super unless method == '__abstract__'
    @__abstract__ = true
  end

  def initialize
    raise InstantiationError, 'Cannot instantiate abstract class' if self.abstract?
  end
end

class Class
  def abstract!
    extend Abstract
  end
end