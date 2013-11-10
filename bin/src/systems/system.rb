class System
  attr_reader :game
  
  def initialize(game)
    @game = game
  end

  def process_one_game_tick
    raise RuntimeError, "systems must override process_one_game_tick()"
  end
end
