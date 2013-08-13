gosu tutorial for Rails Girls The Hague
===================
[gosu][1] is a 2D game development library. Gosu features easy to use and game-friendly interfaces to 2D graphics and text (accelerated by 3D hardware), sound samples and music as well as keyboard, mouse and gamepad/joystick input. Also includes demos for integration with RMagick, Chipmunk and OpenGL.

The actual source code, wiki, issue tracker etc. are all hosted on [GitHub][2]. The best entry point into Gosu's documentation is the [wiki home page][3].

####Install:  
```gem install gosu```

or add ```gem "gosu", "~> 0.7.48"``` to your Gemfile and run ```bundle```.

To test whether everything works as expected, you can use this Hello World script:
```
require 'rubygems' # only necessary in Ruby 1.8
require 'gosu'

class MyWindow < Gosu::Window
  def initialize
   super(640, 480, false)
   self.caption = 'Hello World!'
  end
end

window = MyWindow.new
window.show
```

#####Play around with the example games

```
cd examples
```

and then:
```ruby CptnRuby.rb```

or:
```ruby RMagickIntegration.rb```

or:
```ruby Tutorial.rb```

[1]: http://www.libgosu.org/
[2]: http://github.com/jlnr/gosu/
[3]: http://github.com/jlnr/gosu/wiki
