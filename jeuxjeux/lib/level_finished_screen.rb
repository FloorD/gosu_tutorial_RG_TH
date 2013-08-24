class LevelFinishedScreen

  def initialize(window)
    @window = window
    @title = Image.from_text(
      @window,
      "Level finished, yippeeeeee!!!!!",
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
    @window.show_next_level
  end

end

