module BadgesHelper
  
  def self.tryUnlock(badge,user) 
    unless user.badges.include?(badge)
      user.badges << badge
    end
  end
  
end
