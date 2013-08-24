#!/usr/bin/env ruby -w
$LOAD_PATH << './lib'

require 'rubygems'
require 'gosu'
require 'map'
require 'player'

include Gosu

class Game < Window

   WIDTH = Gosu.screen_width
   HEIGHT = Gosu.screen_height
   WALKING_SPEED = 10

  def initialize
    puts 'You can use puts to print out debugging information'
    super(WIDTH, HEIGHT, false)
    self.caption = "RailsGirls: The Mysteries of Ruby"
    @background_music = Song.new(self, "media/4pm.mp3")
    @background_music.play(true) if false
    @map = Map.new(self, 11, 15)
    @player = Player.new(self)
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
    @map.draw
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape || id == Gosu::KbQ then
      close
    end
  end

  def build_grass
    @tiles = []
    @image = Image.new(self, "media/", true)
  end
end

Game.new.show
