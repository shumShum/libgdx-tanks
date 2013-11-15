class Camera < Component
  attr_accessor :camera

  def initialize(camera)
    super()
    @camera = camera
  end

  def set_camera(x ,y, z)
    @camera.position.set(x, y, z)
  end
end
