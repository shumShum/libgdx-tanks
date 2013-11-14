class Parent < Component
  attr_accessor :parent_type

  def initialize(parent_type)
    super()
    @parent_type = parent_type
  end
  
end
