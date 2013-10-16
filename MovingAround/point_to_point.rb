require 'gosu'
include Gosu

class Ship
  def initialize(window, target_x, target_y)
    @window = window
    @image  = Image.new(@window, "startfighter.bmp", true)
    @x      = 400
    @y      = 100
    @target_x = target_x
    @target_y = target_y
  end

  def update
    @x += 1 if @x < @target_x
    @y += 1 if @y < @target_y
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end

class Game < Window
  def initialize
    super(640, 480, false)
    self.caption = "Do it"
    @target_x = 500
    @target_y = 400
    @ship = Ship.new(self, @target_x, @target_y)
    @gem = Image.new(self, "gem.png", true)
  end

  def update
    @ship.update
  end

  def draw
    @ship.draw
    @gem.draw(@target_x, @target_y, 0)
  end

  def button_down(id)
    if id == KbEscape then close end
  end
end

Game.new.show
