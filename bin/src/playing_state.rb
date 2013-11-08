##
# Copyright 2012, Prylis Incorporated.
#
# This file is part of The Ruby Entity-Component Framework.
# https://github.com/cpowell/ruby-entity-component-framework
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the framework.

java_import com.badlogic.gdx.Screen

require 'entity_manager'

# Necesssary components
require 'components/spatial_state'
require 'components/player_input'
require 'components/fuel'
require 'components/polygon_collidable'

# Necessary systems
require 'systems/rendering_system'
require 'systems/physics'
require 'systems/input_system'
require 'systems/spatial_system'
require 'systems/collision_system'
require 'systems/asteroid_system'

class PlayingState
  include Screen

  def initialize(game)
    @game = game
  end

  # Called when this screen becomes the current screen for a Game.
  def show
    @entity_manager = EntityManager.new

    p1_tank = @entity_manager.create_tagged_entity('p1_tank')
    @entity_manager.add_component p1_tank, SpatialState.new(320, 240, 0, 0)
    @entity_manager.add_component p1_tank, Renderable.new(RELATIVE_ROOT + "res/images/tank.png", 1.0, 0)
    @entity_manager.add_component p1_tank, PlayerInput.new([Input::Keys::A, Input::Keys::S, Input::Keys::D])

    # Initialize systems
    # @physics   = Physics.new(self)
    @input     = InputSystem.new(self)
    @renderer  = RenderingSystem.new(self)
    @engine    = EngineSystem.new(self)
    @collision = CollisionSystem.new(self)
    # @asteroid  = AsteroidSystem.new(self)

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
    # @physics.process_one_game_tick(delta, @entity_manager)
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

