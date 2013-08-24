#!/usr/bin/env ruby -w
$LOAD_PATH << './lib'

require 'rubygems'
require 'gosu'
require 'menu'
require 'level'
require 'map'
require 'colored_gem'
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
    @controller        = Menu.new(self)
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

end

Main.new.show

