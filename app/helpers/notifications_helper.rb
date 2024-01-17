module NotificationsHelper
  def notification_form(notification)
    case notification.action
    when "like" then
      "#{notification.visiter.name}さんがあなたの投稿にいいねしました。"
    end
  end

  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end
end
