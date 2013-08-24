class Menu
  def initialize(window)
    @window = window
    @title = Image.from_text(
      @window,
      "The Mysteries of Ruby",
      Gosu::default_font_name,
      150,
      10,
      WIDTH,
      :center
    )
  end

  def draw
    @title.draw(0,(HEIGHT - 300) / 2,0)
  end

  def update ; end

  def button_down(id)
    if id == Gosu::KbEscape || id == Gosu::KbQ
      @window.close
    elsif id == Gosu::KbSpace
      @window.show_next_level
    end
  end
end

