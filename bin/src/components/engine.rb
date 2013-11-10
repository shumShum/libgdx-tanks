require 'components/component'

class Engine < Component
  attr_accessor :speed, :forward, :on

  def initialize(speed)
    super()
    @speed = speed
    @on = false
  end
end
