require 'forwardable'

class Renderable < Component
  extend Forwardable

  attr_accessor :image, :image, :scale, :rotation

  def initialize(image, scale = 1.0, rotation = 0)
    super()
    @image = image
    @scale = scale
    @rotation  = rotation
  end

  def rotate(amount)
    @rotation += amount
  end

  def encode_with(coder)
    coder['image'] = @image
    coder['scale']    = @scale
    coder['rotation'] = @rotation
  end
  def init_with(coder)
    @image = coder['image']
    @scale    = coder['scale']
    @rotation = coder['rotation']
  end

end
