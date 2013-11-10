java_import com.badlogic.gdx.Screen

require 'entity_manager'

# Necesssary components
require 'components/spatial_state'
require 'components/player_input'
require 'components/polygon_collidable'
require 'components/motion'

# Necessary systems
require 'systems/rendering_system'
require 'systems/input_system'
require 'systems/motion_system'
require 'systems/collision_system'
require 'systems/asteroid_system'

class PlayingState
  include Screen

  PLAYER_INPUT = [Input::Keys::A, Input::Keys::S, Input::Keys::D, Input::Keys::W]

  def initialize(game)
    @game = game
  end

  # Called when this screen becomes the current screen for a Game.
  def show
    @entity_manager = EntityManager.new

    p1_tank = @entity_manager.create_tagged_entity('p1_tank')
    @entity_manager.add_component p1_tank, SpatialState.new(300, 220)
    @entity_manager.add_component p1_tank, Engine.new(0.05)
    @entity_manager.add_component p1_tank, Motion.new
    @entity_manager.add_component p1_tank, Renderable.new(RELATIVE_ROOT + "res/images/tank.png", 1.0, 0)
    @entity_manager.add_component p1_tank, PlayerInput.new(PLAYER_INPUT)

    # Initialize systems
    @input     = InputSystem.new(self)
    @renderer  = RenderingSystem.new(self)
    @engine    = EngineSystem.new(self)
    @motion   = MotionSystem.new(self)
    @collision = CollisionSystem.new(self)

    @bg_image = Texture.new(Gdx.files.internal(RELATIVE_ROOT + 'res/images/bg.jpg'))

    @game_over=false
    @landed=false
    @elapsed=0

    @camera = OrthographicCamera.new
    @camera.setToOrtho(false, 640, 480);
    @batch = SpriteBatch.new
    @font = BitmapFont.new
  end

  def hide
  end

  def render(gdx_delta)
    #Display.sync(120)
    delta = gdx_delta * 1000

    @input.process_one_game_tick(delta, @entity_manager)
    @engine.process_one_game_tick(delta, @entity_manager)
    @motion.process_one_game_tick(delta, @entity_manager)
    @game_over = @collision.process_one_game_tick(delta, @entity_manager)

    @camera.update
    @batch.setProjectionMatrix(@camera.combined)

    @batch.begin

    @batch.draw(@bg_image, 0, 0)

    @renderer.process_one_game_tick(@entity_manager, @camera, @batch, @font)

    @elapsed += delta;
    if (@elapsed >= 1000)
      @game.increment_game_clock(@elapsed/1000*MyGame::GAME_CLOCK_MULTIPLIER)
      @elapsed = 0
    end

    @font.draw(@batch, "FPS: #{Gdx.graphics.getFramesPerSecond}", 8, 460);
    @font.draw(@batch, "ESC to exit", 8, 20);

    @batch.end

    if Gdx.input.isKeyPressed(Input::Keys::ESCAPE)
      @game.setScreen StartupState.new(@game)
    end

  end

  def resize width, height
  end

  def pause

  end

  def resume

  end

  def dispose

  end

end

