class Key

  attr_reader :x, :y

  def initialize(window, column, row)
    @window = window
    @image = Image.new(@window, "media/key.png", true)
    @width = @image.width
    @height = @image.height
    @offset_y = -65
    @x = column * @image.width
    @y = @offset_y + row * 75
  end

  def update
  end

  def draw
    @image.draw(@x,@y, 0)
  end

end
