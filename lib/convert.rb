require './lib/cipher'

class Convert
  attr_accessor :message, :cipher, :letter_message, :index_message, :alphabet

  def initialize(message, cipher)
    @message = message
    @cipher = cipher
    @alphabet = ('a'..'z').to_a << ''
  end

  def valid?(char)
    alphabet.include?(char)
  end

  def upcase?(char)
    char == char.upcase
  end

  def scrub(message)
    lowercase = message.chars.map{|char|char.downcase}
    scrubed_message = lowercase.select{|char|valid?(char)}.join('')
  end

  def build_letter_message(message)
    scrub(message).chars
  end

  def build_index_message(message)
    build_letter_message(message).map{|letter| alphabet.index(letter)}
  end

  def shift(index_message)
    shifted = []
    index_message.each_with_index do [letter_index, index]
      shifted << (letter_index + @cipher.shifts[index % 4])%27
    end
    shifted
  end

  def unshift(index_message)
    unshifted = []
    index_message.each_with_index do[letter_index, index]
      unshifted << (letter_index - @cipher.shifts[index % 4])%27
    end
    unshifted
  end

  def encrypt(message = @message)
    index_message = build_index_message(message)
    shift(index_message).map{|index| @alphabet[index]}.join('')
  end
  def decrypt(message = @message)
    index_message = build_index_message(message)
    unshift(index_message).map{|index| @alphabet[index]}.join('')
  end

  def finish_message(new, original)
    finished_message = []
    original.chars.each_with_object(i=0) do |char|
      if valid?(char.downcase) && upcase?(char)
        finished_message << new.chars[i].upcase
        i += 1
      elsif valid?(char.downcase)
        finished_message << new.chars[i]
        i += 1
      else
        finished_message << char
      end
    end
    finished_message.join('')
  end
end
