module NotificationsHelper
  
  def self.create_notif(user,label,url)
    notification = Notification.new
    notification.user = user
    notification.label = label
    notification.is_checked = false
    notification.date = Date.today
    notification.url = url[1..url.length-1]
    notification.save
  end
end
