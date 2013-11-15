class ImageStorage
  
  IMAGE_PATH_BASE = {
    background: 'res/images/bg.png',
    tank:       'res/images/tank.png',
    enemy_tank: 'res/images/enemy_tank.png',
    bullet:     'res/images/bullet.png'
  }

  attr_reader :image_base

  def initialize
    @image_base = {}
  end

  def get_by_name(image_name)
    @image_base[image_name.to_sym] ||= Texture.new(Gdx.files.internal(RELATIVE_ROOT + IMAGE_PATH_BASE[image_name]))
    @image_base[image_name.to_sym]
  end
end