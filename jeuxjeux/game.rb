#!/usr/bin/env ruby -w
$LOAD_PATH << './lib'

require 'rubygems'
require 'gosu'
require 'map'
require 'colored_gem'
require 'player'

include Gosu

class Game < Window

   WIDTH = 1440
   HEIGHT = 900
   ROWS = 11
   COLUMNS = 15

  def initialize
    puts 'You can use puts to print out debugging information'
    super(WIDTH, HEIGHT, false)
    self.caption       = "RailsGirls: The Mysteries of Ruby"
    @background_music  = Song.new(self, "media/4pm.mp3")
    @map               = Map.new(self, ROWS, COLUMNS)
    @player, @gems     = read_level(ROWS, COLUMNS)
    @background_music.play(true) unless ENV['DISABLE_SOUND'] == 'true'
  end

  def update
    @player.move_left if button_down? KbLeft
    @player.move_right if button_down? KbRight
    @player.move_up if button_down? KbUp
    @player.move_down if button_down? KbDown
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
      close
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
            player = Player.new(self, column, row)
          when 'G'
            gems << ColoredGem.new(self, column, row)
          else
            #nothing
        end
      end
    end

    [player, gems]
  end
end

Game.new.show
