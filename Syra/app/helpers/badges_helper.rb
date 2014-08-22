module BadgesHelper
  
  def self.tryUnlock(badge,user) 
    unless user.badges.include?(badge)
      user.badges << badge
      user.money += badge.reward
      NotificationsHelper.create_notif(user,"Bravo ! Vous avez débloqué le badge '"+badge.label.split(":")[0]+"' et empoché "+badge.reward.to_s,"/users/"+(user.id.to_s),"fa fa-key")
    end
  end
  
  def self.tryUnlockLvls(user)
    if user.level.levelUser == 1
      self.tryUnlock(Badge.find(20),user)
    end
    if user.level.levelUser == 5
      self.tryUnlock(Badge.find(21),user)
    end
    if user.level.levelUser == 10
      self.tryUnlock(Badge.find(22),user)
    end
    if user.level.levelUser == 20
      self.tryUnlock(Badge.find(23),user)
    end
    if user.level.levelUser == 30
      self.tryUnlock(Badge.find(24),user)
    end
  end
  
end
