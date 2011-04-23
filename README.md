Caramel
=======

irb(main):002:0> require './lib/caramel'
=> true

irb(main):003:0> 'john'.is 'john'
=> true

irb(main):004:0> 'john'.is.empty?
=> false

irb(main):005:0> 'john'.is_not.empty?
=> true

irb(main):006:0> 'john'.is_not 'steven'
=> true

irb(main):007:0> shopping_list = ['orange']
=> ["orange"]

irb(main):008:0> 'banana'.in shopping_list
=> false

irb(main):009:0> 'banana'.is_not.in shopping_list
=> true

irb(main):010:0> 'banana'.is.in shopping_list
=> false

