class HealPoints < Component
  attr_accessor :hp

  def initialize(hp = 100)
    super()
    @hp = 100
  end

  def damaged(damage)
    @hp -= damage
  end

end
