class RenderingSystem < System
  
  def process_one_game_tick(entity_mgr, camera, batch, font, image_storage)
    draw_background(batch, camera, image_storage)

    entities = entity_mgr.get_all_entities_with_components_of_type([Renderable, SpatialState])
    entities.each do |e|
      loc_comp    = entity_mgr.get_component_of_type(e, SpatialState)
      render_comp = entity_mgr.get_component_of_type(e, Renderable)
      image = image_storage.get_by_name(render_comp.image)

      drow_image = image_storage.get_by_name(render_comp.image)
      batch.draw(image, loc_comp.x, loc_comp.y,
        image.width/2, image.height/2,
        image.width, image.height,
        1.0, 1.0,
        render_comp.rotation,
        0, 0,
        image.width, image.height,
        false, false
      )
    end
  end

  def draw_background(batch, camera, image_storage)
    bg_image = image_storage.get_by_name(:background)
    batch.draw(bg_image, 0, 0)
  end
end

