class Damage < Component
  attr_accessor :damage

  def initialize(damage)
    super()
    @damage = damage
  end
  
end
