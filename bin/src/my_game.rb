##
# Copyright 2012, Prylis Incorporated.
#
# This file is part of The Ruby Entity-Component Framework.
# https://github.com/cpowell/ruby-entity-component-framework
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the framework.

java_import com.badlogic.gdx.Game

require 'startup_state'

class MyGame < Game
  include ApplicationListener

  attr_reader :game_clock, :is_running

  GAME_CLOCK_MULTIPLIER=1

  def initialize
    @is_running = true
  end

  def create
    @game_clock = Time.now

    setScreen(StartupState.new(self))
  end

  def increment_game_clock(seconds)
    @game_clock += (seconds)
  end

  def dispose
    @is_running = false
  end
end
