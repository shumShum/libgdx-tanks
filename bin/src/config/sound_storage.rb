class SoundStorage
  
  SOUND_PATH_BASE = {
    fire: 'res/sounds/fire.wav',
    damage: 'res/sounds/damage.wav',
    explosion: 'res/sounds/explosion1.wav',
  }

  attr_reader :sound_base

  def initialize
    @sound_base = {}
    SOUND_PATH_BASE.each_pair do |name, path|
      @sound_base[name] = Gdx.audio.newSound(Gdx.files.internal(RELATIVE_ROOT + path)) 
    end
  end

  def get_by_name(sound_name)
    @sound_base[sound_name.to_sym]
  end
end