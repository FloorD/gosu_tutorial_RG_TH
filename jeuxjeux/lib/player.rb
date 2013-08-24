class Player
  def initialize(window)
    @window = window
    @image = Image.new(@window, "media/player.png", true)
    @width = @image.width
    @height = @image.height
    @offset_x = 40
    @offset_y = 60
    @x = @window.width / 2
    @y = @window.height / 2
  end

  def update(x, y)
    new_x = @x + x
    new_y = @y + y
    if fits?(new_x, new_y)
      @x = new_x
      @y = new_y
    end
  end

  def draw
    @image.draw(@x,@y, 0)
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

