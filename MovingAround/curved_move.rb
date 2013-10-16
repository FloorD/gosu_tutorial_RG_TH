require 'gosu'
include Gosu

class Ship
  def initialize(window, target_x, target_y)
    @window = window
    @image  = Image.new(@window, "startfighter.bmp", true)
    @x      = 500
    @y      = 250
    @target_x = target_x
    @target_y = target_y

    startX=@x;
    startY=@y;

    endX=target_x;
    endY=target_y;

    bezierX=300;
    bezierY=50;

    @pos_x = []
    @pos_y = []
    t = 0.0
    while t <= 1.0 do
        @pos_x << ((1-t)*(1-t)*startX + 2*(1-t)*t*bezierX+t*t*endX).to_i
        @pos_y << ((1-t)*(1-t)*startY + 2*(1-t)*t*bezierY+t*t*endY).to_i
        t += 0.01
    end
  end

  def update
    @x = @pos_x.shift || @x
    @y = @pos_y.shift || @y
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
