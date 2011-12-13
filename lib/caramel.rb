module Caramel

  class ObjectModifierWrapper < BasicObject
    attr_accessor :parent

    def initialize parent
      @parent = parent
    end
    
    def method_missing(*args, &block)
      @result = @parent.send(*args, &block)
      return alter
    end

    def alter
      @result
    end

  end




class NilModifierWrapper < ObjectModifierWrapper
  
    def method_missing(*args, &block)
      if @parent != nil
        @result = @parent.send(*args, &block)
      else
        #parent is nil
        @result = nil
      end
      return alter
    end

end



  # Intentionaly left blank
  class IsWrapper < ObjectModifierWrapper
  end

  class NotWrapper < ObjectModifierWrapper
    def alter
      !@result
    end
  end

end

class Object

  # if person.is 'John'
  def is(*args)
    if args.first
      self == args.first
    else
      Caramel::IsWrapper.new self
    end
  end

  # if my_varliable.is_not.empty?
  # if 'Jack'.is_not 'John'
  def not(*args)
    if args.first
      self != args.first
    else
      Caramel::NotWrapper.new self
    end
  end

  # if person.is 'John'
  def and(*args)
    if args.first
      self == args.first
    else
      Caramel::NilModifierWrapper.new self
    end
  end


  alias :is_not :not
  alias :are_not :not


  # if 'apple'.in? @list_of_fruits
  def in? array
    array.include? self
  end
  alias :in :in?
  alias :is_in? :in?
  alias :is_in :in?

end
