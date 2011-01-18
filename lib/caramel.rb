module Caramel

  class ObjectModifierWrapper
    attr_accessor :parent

    def initialize parent
      @parent = parent
    end

    def method_missing(*args)
      @result = @parent.send(*args)
      return modify
    end

    def modify
      puts "we are here"
      @result
    end

  end

  # Intentionaly left blank
  class IsWrapper < ObjectModifierWrapper
  end

  class NotWrapper < ObjectModifierWrapper
    def modify
      puts "modifing #{@result} to #{!@result}"
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
