require 'date'

module HelperMethod
  def today
    Date.today.strftime('%d%m%y')
  end

  def random_key
    '%05d' % rand(0..99999)
  end
end 
