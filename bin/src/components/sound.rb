class Sound < Component
  attr_reader :responsive_sounds
  attr_accessor :queue

  def initialize(sounds)
    super()
    @queue = []
    @responsive_sounds = sounds
  end

  def put(sound)
    if @responsive_sounds.include?(sound)
      @queue << sound
    end
  end

end
