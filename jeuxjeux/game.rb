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
    start = @map.tiles.select{|t| t.free? }.sample
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

  def intersects?(bounds)
    false
  end
end

class Bug
  def initialize(window, map)
    @map = map
    @image = Image.new(window, "media/bug.png", true)
    start = @map.tiles.select{|t| t.free? }.sample
    @x = start.x
    @y = start.y
  end

  def update
    if rand < 0.5
      @y += 1 * (rand < 0.5 ? -1 : 1)
    else
      @x += 1 * (rand < 0.5 ? -1 : 1)
    end
  end

  def draw
    @image.draw(@x,@y, 0)
  end

  def intersects?(bounds)
    false
  end
end

class Door
  def initialize(window, map)
    @map = map
    @image = Image.new(window, "media/door_tall_closed.png", true)
    start = @map.tiles.select{|t| t.free? }.sample
    @x = start.x
    @y = start.y
  end

  def update

  end

  def draw
    @image.draw(@x,@y, 0)
  end

  def intersects?(bounds)
    false
  end
end


class CollectibleGem
  GEMS = ["gem_blue", "gem_green", "gem_orange"]

  def initialize(window, map)
    @map = map
    @image = Image.new(window, "media/#{GEMS.sample}.png", true)
    start = @map.tiles.select{|t| t.free? }.sample
    @x = start.x
    @y = start.y
  end

  def update

  end

  def draw
    @image.draw(@x,@y, 0)
  end

  def intersects?(bounds)
    false
  end
end


class Map
  attr_accessor :entities
  attr_accessor :tiles

  def initialize(window, width, height, rows, columns)
    @entities = []
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

  def update
    @entities.each{|e| e.update}
  end

  def draw
    @tiles.each do |tile|
      tile.draw
    end
    @entities.each do |entity|
      entity.draw
    end
  end

  def free?(bounds)
    return false if bounds.x > Game::WIDTH || bounds.x < 0 || bounds.y < 0 || bounds.y > Game::HEIGHT

    !@entities.any? do |tile|
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
    @background_music = Song.new(self, "media/4pm.mp3")
    @background_music.play(true)
    @map = Map.new(self, WIDTH, HEIGHT, NUMBER_OF_ROWS, NUMBER_OF_COLUMNS)
    4.times do
      @map.entities << Bug.new(self, @map)
    end
    10.times do
      @map.entities << CollectibleGem.new(self, @map)
    end

    @map.entities << Door.new(self, @map)

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
    @map.update
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
