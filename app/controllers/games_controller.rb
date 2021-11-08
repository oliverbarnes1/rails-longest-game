require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(9)
    @time = Time.now
  end

  def score
    @time_taken = params[:time].to_i - Time.now.to_i
    @letters = params[:letters]
    @guess = params[:guess].upcase
    @result = included?(@guess, @letters)
    @english = english_word?(@guess)
    @score = compute_score(@guess, @time_taken)
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def included?(guess, letters)
    guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def compute_score(attempt, time_taken)
    time_taken > 60.0 ? 0 : attempt.size * ((1.0 - time_taken / 60.0) / 100_000).round
  end


end
