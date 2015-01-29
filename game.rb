require 'yaml'
require "./board.rb"

module Hangman

  class Game

    private
    attr_accessor :mistakes_left, :board

    public
    def initialize(args = {})
      @mistakes_left = args.fetch(:mistakes_left, 3)
      #load_hash = args.fetch(:load_game, {})
      #puts "Game.load_hash = #{load_hash}"
      @board = Board.new #:load_game => load_hash)
    end

    def game_over?
      if mistakes_left == 0
        return :lose
      elsif board.match?
        return :win
      else
        return false
      end
    end


    def play
      puts "Welcome to Hangman!!"	

      while game_over? == false
      	puts "The board shows: #{board.display.split('').join(' ')}"       
        old_letters = board.already_selected
        puts "Letters already selected = " + old_letters unless old_letters == ""
        input = get_user_input(mistakes_left, "")
        break if input == "save"
        found = board.submit(input)
        self.mistakes_left = mistakes_left - 1 unless found
      end
      if input == "save"
        puts save
      else
        puts "The word is '#{board.word}'"
        if game_over? == :win
          puts "Congratulations!! You won the game!!"
        else
      	  puts "I'm sorry but you lose!!"
        end # if game_over?
      end # if input
    end

    def save
        yaml_output = YAML::dump(self)
        fname = "sample.txt"
        somefile = File.open(fname, "w")
        somefile.puts yaml_output
        somefile.close
        "Game saved."
    end

# if i have an options_hash as input I can have multiple behavior for input
    def get_user_input(strikes, valid_entries)     
      message = "You have #{strikes} mistakes remaining. Enter a-z, or save"
      puts message
      input = gets.chomp.downcase
#  I should implement error checking here.
      input        
    end


  end  # class

end # module


def load_game
  file = File.open("sample.txt", "r")
  yaml_string = file.read
  #puts yaml_string
  YAML::load(yaml_string)
end

input = 'n'
if (File.exist?("sample.txt"))
  puts "Do you want to load the last saved game?"
  input = gets.chomp.downcase
  # should implement error checking here
end

game = input == 'y' ? load_game : Hangman::Game.new
game.play

