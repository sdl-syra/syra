module UsersHelper
  
  def self.grant_xp(user,xp)
    coeff = 1-(0.05*user.level.levelUser>=1?0.05:0.05*user.level.levelUser)
    user.level.levelUser +=  (user.level.XPUser+(xp*coeff))/100
    user.level.XPUser = (user.level.XPUser+(xp*coeff))%100
    user.level.save
  end
  
  def self.create_activity(user, libelle)
      activite = Activity.new
      activite.user = user
      activite.label = "<a href=/users/" + user.id.to_s + ">" + user.name + " " + user.lastName + " </a> " + libelle
      activite.date = Date.today
      activite.save
  end
end
