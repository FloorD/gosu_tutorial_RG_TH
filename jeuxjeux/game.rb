#!/usr/bin/env ruby -w

require 'rubygems'
require 'gosu'

include Gosu

class Rectangle
  attr_accessor :x,:y,:width, :height
  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end
end

class Block

  attr_reader :x, :y

  def initialize(window, x, y)
    @image = Image.new(window, "media/block.png", true)
    @x = x * Game::TILE_SIZE
    @y = y * Game::TILE_SIZE
  end

  def draw
    @image.draw(@x, @y, 0)
  end

  def intersects?(bounds)
    if bounds.x + bounds.width >= @x && bounds.x <= @x + Game::TILE_SIZE && bounds.y + bounds.height >= @y && bounds.y <= @y + Game::TILE_SIZE
      true
    else
      false
    end
  end

  def free?
    false
  end
end

class EmptyTile
  attr_reader :x, :y

  def initialize(window, x, y)
    @x = x * Game::TILE_SIZE
    @y = y * Game::TILE_SIZE
  end

  def free?
    true
  end

  def intersects?(bounds)
    false
  end

  def draw

  end

end

class Player
  def initialize(window, map)
    @map = map
    @image = Image.new(window, "media/player.png", true)
    start = @map.tiles.detect{|t| t.free? }
    @x = start.x
    @y = start.y
  end

  def update(x, y)
    if @map.free?(Rectangle.new(@x + x + Game::TILE_SIZE / 2, @y + y + Game::TILE_SIZE / 2, 10, 10))
      @x += x
      @y += y
    end
  end

  def draw
    @image.draw(@x,@y, 0)
  end
end

class Map
  attr_reader :tiles

  def initialize(window, width, height, rows, columns)
    @tiles = []
    rows.times do |y|
      columns.times do |x|
        if rand < 0.2
          @tiles << Block.new(window, x, y)
        else
          @tiles << EmptyTile.new(window, x, y)
        end
      end
    end
  end

  def draw
    @tiles.each do |tile|
      tile.draw
    end
  end

  def free?(bounds)
    return false if bounds.x > Game::WIDTH || bounds.x < 0 || bounds.y < 0 || bounds.y > Game::HEIGHT

    !@tiles.any? do |tile|
      if tile.nil?
        false
      else
        tile.intersects?(bounds)
      end
    end
  end
end

class Game < Window

   TILE_SIZE = 56
   WIDTH = 960
   HEIGHT = 640
   NUMBER_OF_ROWS = 11
   NUMBER_OF_COLUMNS = 17
   WALKING_SPEED = 3

   attr_reader :map

  def initialize
    puts 'You can use puts to print out debugging information'
    super(WIDTH, HEIGHT, false)
    self.caption = "RailsGirls: The Mysteries of Ruby"
    @background_image = Image.new(self, "media/map.png", true)
    @map = Map.new(self, WIDTH, HEIGHT, NUMBER_OF_ROWS, NUMBER_OF_COLUMNS)
    @player = Player.new(self, @map)
  end

  def update
    move_x = 0
    move_y = 0
    move_x -= WALKING_SPEED if button_down? KbLeft
    move_x += WALKING_SPEED if button_down? KbRight
    move_y += WALKING_SPEED if button_down? KbDown
    move_y -= WALKING_SPEED if button_down? KbUp

    @player.update(move_x, move_y)
  end

  def draw
    @background_image.draw(0, 0, 0)
    @map.draw
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape || id == Gosu::KbQ then
      close
    end
  end
end

Game.new.show
