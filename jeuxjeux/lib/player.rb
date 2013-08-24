class Player

  WALKING_SPEED = 10

  def initialize(window, column, row)
    @window = window
    @image = Image.new(@window, "media/player.png", true)
    @width = @image.width
    @height = @image.height
    @offset_x = 40
    @offset_y = 70
    @x = column * @image.width
    @y = row * @offset_y
  end

  def update
  end

  def draw
    @image.draw(@x,@y, 0)
  end

  def move_left
    move(-1 * WALKING_SPEED, 0)
  end

  def move_right
    move(WALKING_SPEED, 0)
  end

  def move_up
    move(0, -1 * WALKING_SPEED)
  end

  def move_down
    move(0, WALKING_SPEED)
  end

  def move(x, y)
    new_x = @x + x
    new_y = @y + y
    if fits?(new_x, new_y)
      @x = new_x
      @y = new_y
    end
  end

  def collect_gems(gems)
    gems.reject! do |gem|
      if Gosu::distance(@x, @y, gem.x, gem.y) < 35 then
        true
      else
        false
      end
    end
  end

  def fits?(x, y)
    fits_horizontally?(x) && fits_vertically?(y)
  end

  def fits_horizontally?(x)
    x > -10 && x + @width < @window.width
  end

  def fits_vertically?(y)
    y > 0 - @offset_y && y + @height - @offset_x < @window.height
  end
end

