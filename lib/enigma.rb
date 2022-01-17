class Enigma

  def initialize
  end

  def today
    Date.today.strftime('%d%m%y')
  end

  def random_key
    '%05d' % rand(0..99999)
  end

  def encrypt(message, key = random_key, date = today)
    cipher = Cipher.new(key, date)
    convert = Convert.new(cipher)
    cyphertext = convert.encrypt_message(message)
    return{:encryption => cyphertext, :key => key, :date => date}
  end

  def decrypt(message, key = random_key, date = today)
    cipher = Cipher.new(key, date)
    convert = Convert.new(cipher)
    cyphertext = convert.encrypt_message(message)
    return{:decryption => cyphertext, :key => key, :date => date}
  end
end
