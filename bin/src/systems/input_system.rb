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

      if key_pressed?(input_component, P1_KEY_FORWARD) && 
          entity_mgr.has_component_of_type(entity, Engine)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)
        engine_component.move(true)
      end

      if key_pressed?(input_component, P1_KEY_BACK) && 
          entity_mgr.has_component_of_type(entity, Engine)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)
        engine_component.move(false)
      end

      if key_pressed?(input_component, P1_KEY_ROTL)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)
        engine_component.rotate(delta * 0.1)

        renderable_component = entity_mgr.get_component_of_type(entity, Renderable)
        renderable_component.rotate(delta * 0.1)
      end

      if key_pressed?(input_component, P1_KEY_ROTR)
        engine_component = entity_mgr.get_component_of_type(entity, Engine)
        engine_component.rotate(delta * -0.1)

        renderable_component = entity_mgr.get_component_of_type(entity, Renderable)
        renderable_component.rotate(delta * -0.1)
      end

      if key_pressed?(input_component, P1_KEY_FIRE) && 
          entity_mgr.has_component_of_type(entity, Fire)

        fire_component = entity_mgr.get_component_of_type(entity, Fire)
        fire_component.fire!
      end

    end
  end

  private

  def key_pressed?(input_component, key)
    Gdx.input.isKeyPressed(key) && input_component.responsive_key?(key)
  end

end
