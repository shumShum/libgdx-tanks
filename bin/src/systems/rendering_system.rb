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
    bg = image_storage.get_by_name(:background)
    cam_x, cam_y = camera.position.x, camera.position.y
    w = bg.width
    h = bg.height

    bg_x = cam_x - cam_x%w
    bg_y = cam_y - cam_y%h

    batch.draw(bg, bg_x, bg_y)

    over = bg_x > cam_x - w/2
    right = bg_y >= cam_y - h/2
    if over 
      batch.draw(bg, bg_x - w, bg_y)
    else
      batch.draw(bg, bg_x + w, bg_y)
    end
    
    if right
      batch.draw(bg, bg_x, bg_y - h)
    else
      batch.draw(bg, bg_x, bg_y + h)
    end

    if over && right
      batch.draw(bg, bg_x - w, bg_y - h)
    end
    if !over && !right
      batch.draw(bg, bg_x + w, bg_y + h)
    end
    if over && !right
      batch.draw(bg, bg_x - w, bg_y + h)
    end
    if !over && right
      batch.draw(bg, bg_x + w, bg_y - h)
    end
  end
end

