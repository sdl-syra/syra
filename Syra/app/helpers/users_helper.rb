module UsersHelper
  
  def self.grant_xp(user,xp)
    if  (user.level.XPUser+xp)/100 > 0
       user.level.levelUser =  (user.level.XPUser+xp)/100
    end
    user.level.XPUser = (user.level.XPUser+xp)%100
  end
end
