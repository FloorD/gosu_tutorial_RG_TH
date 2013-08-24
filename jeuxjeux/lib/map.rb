class Map
  def initialize(window, rows, columns)
    @window = window
    @tiles = setup_tiles(window, rows, columns)
  end

  def draw
    @tiles.each{|t| t[:image].draw(t[:x], t[:y], 0) }
  end

  def setup_tiles(window, rows, columns)
    tiles = []
    image = Image.new(window, "media/grass_block.png", true)
    rows.times do |y|
      columns.times do |x|
        tiles << {
          :image => image,
          :x => x * image.width,
          :y => -45 + y * 85
        }
      end
    end

    tiles
  end
end
