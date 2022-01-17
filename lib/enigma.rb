class Enigma

  def initialize
  end

  def today
    Date.today.strftime('%d%m%y')
  end

  def encrypt(message, key, date = today)
    cipher = Cipher.new(key, date)
    convert = Convert.new
    cyphertext = convert.encrypt(message, cipher.shift)
    return{:encryption => cyphertext, :key => key, :date => date}
  end

  def decrypt(message, key, date = today)
    cipher = Cipher.new(key, date)
    convert = Convert.new
    cyphertext = convert.encrypt(message, cipher.shift)
    return{:decryption => cyphertext, :key => key, :date => date}
  end
end
