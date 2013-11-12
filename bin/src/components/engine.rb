class Engine < Component
  attr_accessor :speed, :forward, :rotation, :control_move, :on

  def initialize(speed, on = false, rotation = 0, control_move = false)
    super()
    @rotation = 0
    @speed = speed
    @on = on
    @rotation = rotation
    @control_move = control_move
  end

  def rotate(amount)
    @rotation += amount
  end

  def move(forward = true)
    @on = true
    @forward = forward
  end 
end
