require 'components/component'

class PlayerInput < Component
  attr_reader :responsive_keys

  def initialize(keys)
    super()
    @responsive_keys = keys  
  end

  def responsive_key?(key)
    @responsive_keys.include? key
  end
  
end
