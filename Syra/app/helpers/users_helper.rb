module UsersHelper
  
  def self.grant_xp(user,xp)
    coeff = 1-(0.05*user.level.levelUser>=1?0.05:0.05*user.level.levelUser)
    user.level.levelUser +=  (user.level.XPUser+(xp*coeff))/100
    user.level.XPUser = (user.level.XPUser+(xp*coeff))%100
    user.level.save
  end
end
