class ColoredGem

  attr_reader :x, :y

  def initialize(window, column, row)
    @window = window

    @images = [
      Image.new(window, "media/gem_green.png"),
      Image.new(window, "media/gem_orange.png"),
      Image.new(window, "media/gem_blue.png")
    ]
    @x = column * 101
    @y = -70 + row * 85
  end

  def draw
    modulo = Gosu::milliseconds / 500 % @images.size
    image = @images[modulo]
    image.draw(@x + modulo, @y + modulo, 0)
  end
end
