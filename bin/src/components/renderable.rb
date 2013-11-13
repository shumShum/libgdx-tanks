require 'forwardable'

class Renderable < Component
  extend Forwardable
  def_delegators :@image, :width, :height

  attr_accessor :image, :image_fn, :scale, :rotation

  def initialize(image_fn, scale = 1.0, rotation = 0)
    super()
    @image_fn   = image_fn
    @image      = Texture.new(Gdx.files.internal(image_fn))
    @scale      = scale
    @rotation   = rotation
  end

  def rotate(amount)
    @rotation += amount
  end

  def encode_with(coder)
    coder['image_fn'] = @image_fn
    coder['scale']    = @scale
    coder['rotation'] = @rotation
  end
  def init_with(coder)
    @image_fn = coder['image_fn']
    @scale    = coder['scale']
    @rotation = coder['rotation']
    @image    = Texture.new(Gdx.files.internal(image_fn))
  end

end
