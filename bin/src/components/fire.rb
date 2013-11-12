class Fire < Component
  attr_accessor :pli, :bullet_reload, :reload_time

  def initialize(reload_time)
    super()
    @pli = false
    @bullet_reload = 0
    @reload_time = reload_time
  end

  def fire!
    if @bullet_reload == 0
      @pli = true
      @bullet_reload = reload_time
    end
  end
end
