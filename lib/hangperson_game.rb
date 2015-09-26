class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(c)
    raise ArgumentError if c == ''
    raise ArgumentError if c == nil
    raise ArgumentError if not c.match(/^[[:alpha:]]$/)
    c.downcase!
    if @word.include?(c) then
      if @guesses.include?(c) then
        return false
      else
        @guesses += c
        return true
      end
    else 
      if @wrong_guesses.include?(c) then
        return false
      else
        @wrong_guesses += c
        return true
      end
    end
  end
  
  def word_with_guesses
    word_guesses = '';
    @word.split('').each { |c| 
      if(@guesses.include?(c)) then
        word_guesses += c
      else
        word_guesses += '-'
      end
    }
    return word_guesses
  end
  
  def check_win_or_lose
    if self.word_with_guesses == @word then
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
