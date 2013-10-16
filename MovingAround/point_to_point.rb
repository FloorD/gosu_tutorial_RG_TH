require 'gosu'
include Gosu

class Ship
  def initialize(window, target_x, target_y)
    @window = window
    @image  = Image.new(@window, "startfighter.bmp", true)
    @x      = 300
    @y      = 50
    @target_x = target_x
    @target_y = target_y
  end

  def update
    if @x < @target_x
      @x += 1
    elsif @x > @target_x
      @x -= 1
    end

    if @y < @target_y
      @y += 1
    elsif @y > @target_y
      @y -= 1
    end
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end

class Game < Window
  def initialize
    super(640, 480, false)
    self.caption = "Do it"
    @target_x = 100
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
