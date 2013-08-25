class Tile

  attr_reader :x, :y

  def initialize(window, row, column, image, walkable)
    @window = window
    @walkable = walkable
    @image = image
    @width = @image.width
    @height = @image.height
    @offset_y = 45
    @x = column * @image.width
    @y = row * 85 - @offset_y
    @hit_box = {:x => @x, :y => @y + @offset_y, :width => 80, :height => 80}
  end

  def update
  end

  def draw
    @image.draw(@x,@y, 0)
  end

  def blocked?(hit_box)
    @walkable == false && collision?(hit_box)
  end

  def collision?(hit_box)
    if hit_box[:x] + hit_box[:width] >= @hit_box[:x] &&
      hit_box[:x] <= @hit_box[:x] + @hit_box[:width] &&
      hit_box[:y] + hit_box[:height] >= @hit_box[:y] &&
      hit_box[:y] <= @hit_box[:y] + @hit_box[:height]
      true
    else
      false
    end
  end

end
