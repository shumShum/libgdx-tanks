require 'components/renderable'
require 'components/engine'

require 'systems/engine_system'

class InputSystem < System
  P1_KEY_BACK = Input::Keys::S
  P1_KEY_FORWARD = Input::Keys::W
  P1_KEY_ROTL   = Input::Keys::A
  P1_KEY_ROTR   = Input::Keys::D
  P1_KEY_FIRE = Input::Keys::SPACE

  def process_one_game_tick(delta, entity_mgr)
    inputtable_entities = entity_mgr.get_all_entities_with_component_of_type(PlayerInput)
    inputtable_entities.each do |entity|
      input_component = entity_mgr.get_component_of_type(entity, PlayerInput)

      if Gdx.input.isKeyPressed(P1_KEY_FORWARD) && 
          input_component.responsive_keys.include?(P1_KEY_FORWARD) && 
          entity_mgr.has_component_of_type(entity, Engine)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)
        engine_component.forward = true
        engine_component.on = true
      end

      if Gdx.input.isKeyPressed(P1_KEY_BACK) && 
          input_component.responsive_keys.include?(P1_KEY_BACK) && 
          entity_mgr.has_component_of_type(entity, Engine)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)
        engine_component.forward = false
        engine_component.on = true
      end

      if Gdx.input.isKeyPressed(P1_KEY_ROTL) && 
          input_component.responsive_keys.include?(P1_KEY_ROTL)
          
        engine_component = entity_mgr.get_component_of_type(entity, Engine)
        engine_component.rotate(delta * 0.1)

        renderable_component = entity_mgr.get_component_of_type(entity, Renderable)
        renderable_component.rotate(delta * 0.1)
      end

      if Gdx.input.isKeyPressed(P1_KEY_ROTR) && 
          input_component.responsive_keys.include?(P1_KEY_ROTR)
        
        engine_component = entity_mgr.get_component_of_type(entity, Engine)
        engine_component.rotate(delta * -0.1)

        renderable_component = entity_mgr.get_component_of_type(entity, Renderable)
        renderable_component.rotate(delta * -0.1)
      end

      if Gdx.input.isKeyPressed(P1_KEY_FIRE) &&
          input_component.responsive_keys.include?(P1_KEY_FIRE)

        spatial_component = entity_mgr.get_component_of_type(entity, SpatialState)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)

        starting_x = spatial_component.x
        starting_y = spatial_component.y
        rotation = engine_component.rotation
        bullet = entity_mgr.create_tagged_entity('bullet')
        entity_mgr.add_component bullet, SpatialState.new(starting_x, starting_y)
        entity_mgr.add_component bullet, Renderable.new(RELATIVE_ROOT + "res/images/bullet.png", 1.0, 0)
        entity_mgr.add_component bullet, Motion.new
        entity_mgr.add_component bullet, Engine.new(0.1, true, rotation)
      end

    end
  end
end
