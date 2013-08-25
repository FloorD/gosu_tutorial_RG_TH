#!/usr/bin/env ruby -w

require 'rubygems'
require 'gosu'

# just require all files in lib directory
# I'm lazy
$LOAD_PATH << './lib'
Dir.glob("lib/*.rb").each do |file|
  require File.basename(file, "*.rb")
end

include Gosu

WIDTH = 1440
HEIGHT = 900

class Main < Window

  attr_accessor :controller

  def initialize
    puts 'You can use puts to print out debugging information'
    super(WIDTH, HEIGHT, false)
    self.caption            = "RailsGirls: The Mysteries of Ruby"
    @menu_controller        = Menu.new(self)
    @game_over_screen       = GameOverScreen.new(self)
    @level_finished_screen  = LevelFinishedScreen.new(self)
    @controller             = @menu_controller
    @levels                 = read_levels
    show_main_menu
  end

  def show_main_menu
    @levels = read_levels
    @controller = @menu_controller
  end

  def show_next_level
    next_level = @levels.pop
    if next_level
      @controller = Level.new(self, next_level)
    else
      show_main_menu
    end
  end

  def show_game_over_screen
    @controller = @game_over_screen
  end

  def show_level_finished_screen
    @controller = @level_finished_screen
  end

  def update
    @controller.update
  end

  def draw
   @controller.draw
  end

  def button_down(id)
    @controller.button_down(id)
  end

  protected

  def read_levels
    Dir.glob("levels/*.txt").map do |path|
      {
        :path  => path,
        :level => File.basename(path, ".txt").to_i
      }
    end.reverse
  end

end

Main.new.show

