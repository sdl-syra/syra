module BadgesHelper
  
  def self.tryUnlock(badge,user) 
    unless user.badges.include?(badge)
      user.badges << badge
      NotificationsHelper.create_notif(user,"Bravo ! Vous avez débloqué le badge '"+badge.label.split(":")[0]+"'","/users/"+(user.id.to_s),"fa fa-key")
    end
  end
  
end
