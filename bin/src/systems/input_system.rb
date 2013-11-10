require 'components/renderable'
require 'components/engine'

require 'systems/engine_system'

class InputSystem < System
  P1_KEY_BACK = Input::Keys::S
  P1_KEY_FORWARD = Input::Keys::W
  P1_KEY_ROTL   = Input::Keys::A
  P1_KEY_ROTR   = Input::Keys::D

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
          
        renderable_component = entity_mgr.get_component_of_type(entity, Renderable)
        renderable_component.rotate(delta * 0.1)
      end

      if Gdx.input.isKeyPressed(P1_KEY_ROTR) && 
          input_component.responsive_keys.include?(P1_KEY_ROTR)
        
        renderable_component = entity_mgr.get_component_of_type(entity, Renderable)
        renderable_component.rotate(delta * -0.1)
      end
    end
  end
end
