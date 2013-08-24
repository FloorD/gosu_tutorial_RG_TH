#!/usr/bin/env ruby -w
$LOAD_PATH << './lib'

require 'rubygems'
require 'gosu'
require 'menu'
require 'level'
require 'map'
require 'colored_gem'
require 'bug'
require 'player'

include Gosu

WIDTH = 1440
HEIGHT = 900

class Main < Window

  attr_accessor :controller

  def initialize
    puts 'You can use puts to print out debugging information'
    super(WIDTH, HEIGHT, false)
    self.caption       = "RailsGirls: The Mysteries of Ruby"
    @menu_controller   = Menu.new(self)
    @controller        = @menu_controller
    @levels            = read_levels
    @controller        = show_next_level
  end

  def show_main_menu
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

