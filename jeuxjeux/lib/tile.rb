class Tile

  attr_reader :x, :y

  def initialize(window, row, column, image, walkable)
    @window = window
    @walkable = walkable
    @image = image #@Image.new(@window, "media/.png", true)
    @width = @image.width
    @height = @image.height
    @offset_y = -45
    @x = column * @image.width
    @y = @offset_y + row * 85
  end

  def update
  end

  def draw
    @image.draw(@x,@y, 0)
  end

end
