class Map

  def initialize(window)
    @window = window
    @tiles = [] #setup_tiles(window, rows, columns)
    @water_image = Image.new(window, "media/water.png", true)
    @grass_image = Image.new(window, "media/grass_block.png", true)
  end

  def draw
    @tiles.each{|t| t.draw }
  end

  def add_tile(row, column, type)
    tile = case type
      when 'W'
        Tile.new(@window, row, column, @water_image, false)
      else
        Tile.new(@window, row, column, @grass_image, true)
    end
    @tiles << tile
  end

  def walkable?(hit_box)
    blocked = @tiles.any? do |tile|
      tile.blocked?(hit_box)
    end
    !blocked
  end

end
