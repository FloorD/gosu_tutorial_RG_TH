class GameOverScreen

  def initialize(window)
    @window = window
    @title = Image.from_text(
      @window,
      "Game Over !!!!",
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
    @window.show_main_menu
  end

end
