Open your texteditor and paste  
```
#!/usr/bin/env ruby -w  
require 'rubygems'  
require 'gosu'  
include Gosu  
```

... right at the top of your empty file. Save your file as ```game.rb```. Now that we've got the necessary gem covered, we can move on to creating our ```classes```.  
Let's start with our environment:  
```
class Rectangle  
end  

class Block  
end  
```

#####attr_accessor, attr_reader & attr_writer
Ruby has this handy and convenient way to share instance variables by using keys like: 
```
attr_accessor :var  
attr_reader :var  
attr_writer :var  
```

You may use the different accessors to communicate your intent to someone reading your code, and make it easier to write classes which will work correctly no matter how their public API is called.  
The attr_... helpers come in pretty handy, just imagine you'd need to hand- write the accessors yourself over and over again!  

Want to know more about ```attr``? [You can][1]!

Why did we bring this up? Because we need the ```attr``` helpers to define the sizes of our game's elements! 

Here we go:
```
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
```

See that ```"media/block.png"``` part? We've prepared something for you! In the **media** folder, you'll find some images we'll use for our game. Go ahead, check it out! 

[1]: http://ruby-doc.org/core-2.0/Module.html#method-i-attr

