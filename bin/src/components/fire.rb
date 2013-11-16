class Fire < Component
  attr_accessor :pli, :bullet_reload, :reload_time, :damage

  def initialize(reload_time, damage, bullet_reload = 0)
    super()
    @pli = false
    @bullet_reload = bullet_reload
    @reload_time = reload_time
    @damage = damage
  end

  def fire!
    if @bullet_reload == 0
      @pli = true
      @bullet_reload = reload_time
    end
  end
end
