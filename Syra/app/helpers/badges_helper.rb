module BadgesHelper
  
  def self.tryUnlock(badge,user) 
    unless user.badges.include?(badge)
      user.badges << badge
      user.money += badge.reward
      NotificationsHelper.create_notif(user,"Bravo ! Vous avez débloqué le badge '"+badge.label.split(":")[0]+"' et empoché "+badge.reward.to_s,"/users/"+(user.id.to_s),"fa fa-key")
    end
  end
  
end
