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
    @speed_per_tick = 2
  end

  def update
    #constant speed you want the object to move at
    delta_x = @target_x - @x
    delta_y = @target_y - @y

    # pythagoras to get the distance
    # Using vectors works as well
    # Gosu.distance would also work
    goal_dist = Math.sqrt( (delta_x * delta_x) + (delta_y * delta_y) )

    if (goal_dist > @speed_per_tick)
      ratio = @speed_per_tick / goal_dist
      x_move = ratio * delta_x
      y_move = ratio * delta_y
      @x += x_move
      @y += y_move
    else
      @x = @target_x
      @y = @target_y
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
    @target_x = 50
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
