# MacroCommand, Command, Mediator and Proxy all have a need to send Notifications.
# 
# The Notifier provides a common method called send_notification that relieves 
# implementation code of the necessity to actually construct Notifications.
# 
# The Notifier class, which all of the above mentioned classes extend, provides 
# an initialized reference to the Facade Singleton, which is required for the 
# convienience method for sending Notifications, but also eases implementation 
# as these classes have frequent Facade interactions and usually require access
# to the facade anyway.
class Notifier

  # Create and send an Notification.
  #
  # Keeps us from having to construct new Notification instances in our implementation code.
  def send_notification(notification_name, body=nil, type=nil)
    facade.send_notification(notification_name, body, type)
  end
  
  # Local reference to the Facade Singleton
  def facade
    Facade.instance
  end
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
