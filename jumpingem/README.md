#RailsGirls: Jumping Gem

We're using the [gosu](http://www.libgosu.org/) 2D game development library for our little game.

``` gem install gosu ```

or add ``` gem "gosu", "~> 0.7.48" ``` to your Gemfile and run ```bundle```.

###Play around with the example games

Change directory to unlock some awesome-looking example games:

``` cd $GEM_HOME/gems/gosu-0.7.48/examples ```

and then:
``` ruby CptnRuby.rb ```

or:
``` ruby RMagickIntegration.rb ```

or:
``` ruby Tutorial.rb ```

##Enough with those examples already!

Copy the repository by opening (a new tab in your) terminal. If you were working on the Rails Girls app in the mean time, make sure you're in your home directory by running ```cd```.

Now run
``` git clone https://github.com/FloorD/gosu_tutorial_RG_TH.git ```

aaand change into the proper directory using ```cd gosu_tutorial_RG_TH/jumpingem```.


##Run!

To play our little game, open it using the terminal:

``` ruby game.rb ```

###So how does this work?

Let's inspect some code, shall we? Open ```game.rb``` in your texteditor. See the

``` #!/usr/bin/env ruby -w ```
``` require 'rubygems' ```
``` require 'gosu' ```
``` include Gosu ```

... right at the top of your empty file? Here we make sure we 'call' the necessary gem, so we can move on to our ```class``` (or multiple classes).
So we have our

``` class Game < Window ```   
``` end ```

... thing going on. The ```def```'s you see within this Game class, are  methods. Here we **def**ine which instructions the program should follow. Take a look for instance at the following snippet:
<pre>
def draw
  draw_quad 0, 400, Color::WHITE, 640, 400, Color::WHITE, 640, 500, Color::WHITE, 0, 500, Color::WHITE
    if @dir == :left then
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
  end
  @cur_image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
end
</pre>

Want to play around a bit? Copy the contents of ```game.rb``` in a new ```.rb``` file. Save it and name it as you'd like. Now try and change some stuff in the game and run it in your terminal to see the changes.

Think you have more graphic skills than Patrick? Then you can try and create a new ```sprites.png```! Don't forget to call it here:

<pre>
def initialize
    super(640, 480, false)
    self.caption = "Jump 'n Run"
    @standing, @walk1, @walk2, @jump = *Image.load_tiles(self, "sprites.png", 100, 160, false)
    @x, @y = 400, 0
    @vy = 0
    @dir = :left
    @cur_image = @standing
  end
</pre>

And see the ```Game.new.show```? That creates a new instance. It has no memory, so when you get stuck in the game, you can just start a new game.

##Assets

The ones used in vim adventures, you can find them [here](http://www.lostgarden.com/2007/05/dancs-miraculously-flexible-game.html)

##Sounds

[Matthew Klingensmith (www.matthewklingensmith.com)](http://opengameart.org/content/matts-creative-commons-music)

####Happy coding!
