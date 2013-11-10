require 'components/component'

class SpatialState < Component
  attr_accessor :x, :y, :dx, :dy

  def initialize(x_pos, y_pos, x_velo = 0, y_velo = 0)
    super()
    @x  = x_pos
    @y  = y_pos
    @dx = x_velo
    @dy = y_velo
  end

end
