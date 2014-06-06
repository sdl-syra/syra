module NotificationsHelper
  
  def self.create_notif(user,label,url)
    notification = Notification.new
    notification.user = user
    notification.label = label
    notification.is_checked = false
    notification.date = Date.today
    notification.url = "propositions/"+url
    notification.save
  end
end
