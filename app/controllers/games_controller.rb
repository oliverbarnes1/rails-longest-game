class GamesController < ApplicationController
  def new
    @letters = generate_grid(9)
  end

  def score
    @letters = params[:letters]
    @score = params[:guess]
    # check_answer(@score, @letters)
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  # def check_answer(score, letters)

  # end
end
