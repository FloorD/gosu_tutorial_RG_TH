#!/usr/bin/env ruby -w

require 'rubygems'
require 'gosu'

include Gosu

class Tile
  def initialize(window, x, y)
    @image = Image.new(window, "media/block.png", true)
    @x = x * @image.width + Game::OFFSET_X
    @y = y * @image.height + Game::OFFSET_Y
  end

  def draw
    @image.draw(@x, @y, 0)
  end
end

class Player
  def initialize(window)
    @image = Image.new(window, "media/player.png", true)
    @x = 580
    @y = 500
  end

  def update(x, y)
    @x += x
    @y += y
  end

  def draw
    @image.draw(@x,@y, 0)
  end
end

class Game < Window

   WIDTH = 960
   HEIGHT = 640
   OFFSET_X = 112
   OFFSET_Y = 14
   NUMBER_OF_ROWS = 11
   NUMBER_OF_COLUMNS = 15

  def initialize
    puts 'You can use puts to print out debugging information'
    super(WIDTH, HEIGHT, false)
    self.caption = "RailsGirls: The Mysteries of Ruby"
    @background_image = Image.new(self, "media/map.png", true)
    @tiles = []
    @player = Player.new(self)

    NUMBER_OF_ROWS.times do |y|
      NUMBER_OF_COLUMNS.times do |x|
        if rand < 0.2
          @tiles << Tile.new(self, x, y)
        end
      end
    end

  end

  def update
    move_x = 0
    move_y = 0
    move_x -= 5 if button_down? KbLeft
    move_x += 5 if button_down? KbRight
    move_y += 5 if button_down? KbDown
    move_y -= 5 if button_down? KbUp

    @player.update(move_x, move_y)
  end

  def draw
    @background_image.draw(0, 0, 0)
    @tiles.each do |tile|
      tile.draw
    end
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape || id == Gosu::KbQ then
      close
    end
  end
end

Game.new.show
