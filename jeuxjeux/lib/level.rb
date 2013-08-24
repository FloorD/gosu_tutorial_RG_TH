class Level

  ROWS = 11
  COLUMNS = 15

  def initialize(window)
    @window            = window
    @window.caption    = "RailsGirls: The Mysteries of Ruby"
    @background_music  = Song.new(@window, "media/4pm.mp3")
    @map               = Map.new(@window, ROWS, COLUMNS)
    @player, @gems     = read_level(ROWS, COLUMNS)
    @background_music.play(true) unless ENV['DISABLE_SOUND'] == 'true'
  end

  def update
    @player.move_left   if @window.button_down? KbLeft
    @player.move_right  if @window.button_down? KbRight
    @player.move_up     if @window.button_down? KbUp
    @player.move_down   if @window.button_down? KbDown
    @player.collect_gems(@gems)
  end

  def draw
    @map.draw
    @gems.each do |g|
      g.draw
    end
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape || id == Gosu::KbQ then
      @window.controller = Menu.new(@window)
    end
  end

  def read_level(rows, columns)
    player = nil
    gems   = []
    level  = File.open('level/001.txt').readlines[1..-1]

    rows.times do |row|
      columns.times do |column|
        case level[row][column]
          when 'P'
            player = Player.new(@window, column, row)
          when 'G'
            gems << ColoredGem.new(@window, column, row)
          else
            #nothing
        end
      end
    end

    [player, gems]
  end
end

