require 'components/component'

class PolygonCollidable < Component
  attr_accessor :bounding_polygon

  def marshal_dump
    [@id]
  end

  def marshal_load(array)
    @id = array
  end
end
