module UsersHelper
  def self.xpToGet
    return [0,90,188,293,406,854,1330,1834,2366,2926,3976,5076,6226,7426,8676,9976,11326,
      12726,14176,15676,17807,20007,22276,24614,27020,29495,32039,34652,37333,
      40084, 43333]
  end

  def self.getPercent(xp)
    xpToGet = self.xpToGet
    return 100 if xp >= xpToGet[xpToGet.length-1]
    minTab = xpToGet.select{|x| x < xp || x == xp}
    min = minTab[minTab.length-1]
    max = xpToGet.select{|x| x > xp}[0]
    return (((xp.to_f-min.to_f)/(max.to_f-min.to_f))*100).round
  end

  def self.grant_xp(user,xp)
    xpToGet = self.xpToGet
    user.level.XPUser += xp
    if user.level.levelUser < 30 && user.level.XPUser > xpToGet[user.level.levelUser]
      index = xpToGet.index{|x| x > user.level.XPUser}
    user.level.levelUser = index
    end
    user.level.save
  end

  def self.create_activity(user, libelle)
    activite = Activity.new
    activite.user = user
    activite.label = "<a href=/users/" + user.id.to_s + ">" + user.name + " " + user.lastName + " </a> " + libelle
    activite.date = Date.today
    activite.save
  end

  def self.generate_code
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789'
    code = ''
    32.times { code << chars[rand(chars.size)] }
    code
  end

end