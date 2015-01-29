module Hangman

  class Board

    # Does alphabet need to be public because
    private
    attr_accessor :alphabet

    public
    attr_reader :word

    ##selects random word from file (internal array first)
    def initialize(args = {})
      # select word for game
      @word = args.fetch(:word, random_word) #{}"animal" #fetch(word, random_from_file_with_constraints)
      # keep track of letters already chosen
      # the hash will associate keys to itself. default will return '_'
      # Setting a default value for the hash does not work properly in conjunction with YAML dump method.
      # new hash created with YAML::dump does not maintain default property of hash. Therefore default value
      # must be forced as it is in display below
      #@alphabet = Hash.new('_')
      @alphabet = Hash.new
    end

    # make it so char is returned by hash if char exists in alphabet, else '-' is returned by hash
    # true/false returned if char matches hangman word
    def submit(char)
      alphabet[char.downcase] = char.downcase
      return true if word.downcase.include?(char)
      return false
    end

    def match?
      word.downcase == display.downcase
    end

    # iterate through each character and replace char with itself or
    # with '_' depending on whether character has/has not been selected.
    def display
      word.split('').map { |char| alphabet[char.downcase] != nil ? alphabet[char.downcase] : '_'  }.join('')
    end   


    def already_selected
      alphabet.keys.sort.join(', ')
    end

    def random_word
      dictionary = []
      # still need to check for existence of file. could do that inside initialize 
      File.open("5desk.txt").each { |line| dictionary << line.chomp if (5..12).include?(line.length-1) }
      result = dictionary[rand(dictionary.length)]
      result
    end

  end  

  #board = Board.new(:load_game => {'a' => 'a'})
  #puts board.match?
  #puts board.submit("z")
  #board.submit('n')
  #board.submit('i')
  #board.submit('m')
  #puts board.match?
  #puts board.display
  #puts board.word
  #puts board.already_selected

end