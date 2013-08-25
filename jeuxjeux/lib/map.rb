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
    image = case type
      when 'W'
        @water_image
      else
        @grass_image
    end
    @tiles << Tile.new(@window, row, column, image, false)
  end

end
