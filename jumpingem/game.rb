#!/usr/bin/env ruby -w
require 'rubygems'
require 'gosu'
include Gosu


class Game < Window
  def initialize
    super(640, 480, false)
    self.caption = "Jump 'n Run"
    @standing, @walk1, @walk2, @jump = *Image.load_tiles(self, "sprites.png", 100, 160, false)
    @x, @y = 200, 200
    @vy = 0
    @dir = :left
    @cur_image = @standing
  end

  def update
    move_x = 0
    move_x -= 5 if button_down? KbLeft
    move_x += 5 if button_down? KbRight

    # Select image depending on action
    if (move_x == 0)
      @cur_image = @standing
    else
      @cur_image = (milliseconds / 175 % 2 == 0) ? @walk1 : @walk2
    end

    if (@vy < 0)
      @cur_image = @jump
    end

    # Directional walking, horizontal movement
    if move_x > 0 then
      @dir = :right
      move_x.times { @x += 1 }
    end
    if move_x < 0 then
      @dir = :left
      (-move_x).times { @x -= 1 }
    end

    # Acceleration/gravity
    # By adding 1 each frame, and (ideally) adding vy to y, the player's
    # jumping curve will be the parabole we want it to be.
    @vy += 1
    # Vertical movement
    if @vy > 0 && @y < 300 then
      @vy.times { @y += 1 }
    end
    if @vy < 0 then
      (-@vy).times {@y -= 1}
    end

  end

  def draw
    if @dir == :left then
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    @cur_image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
  end

  def button_down(id)
    if id == KbUp then
      @vy = -20
    end
    if id == KbEscape then close end
  end
end

Game.new.show
