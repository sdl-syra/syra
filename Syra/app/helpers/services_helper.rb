module ServicesHelper
  
  def self.generate_code
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'
    code = ''
    8.times { code << chars[rand(chars.size)] }
    code
  end

end
