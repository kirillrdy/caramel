module Caramel
  class NotWrapper
    attr_accessor :parent

    def initialize parent
      @parent = parent
    end

    def method_missing(*args)
      result = parent.send(*args)
      return !result
    end

  end

end

class Object

  def not
    Caramel::NotWrapper.new self
  end

  alias :is_not :not
  alias :are_not :not

end
