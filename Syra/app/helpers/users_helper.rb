module UsersHelper
  
  def self.grant_xp(user,xp)
    user.level.levelUser +=  (user.level.XPUser+xp)/100
    user.level.XPUser = (user.level.XPUser+xp)%100
    user.level.save
  end
end
