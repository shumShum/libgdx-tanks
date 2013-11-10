require 'components/component'

class Engine < Component
  attr_accessor :speed, :forward, :rotation, :on

  def initialize(speed, on = false, rotation = 0)
    super()
    @rotation = 0
    @speed = speed
    @on = on
    @rotation = rotation
  end

  def rotate(amount)
    @rotation += amount
  end
end
