# Your subclass should override the execute method where your business logic 
# will handle the Notification.
class SimpleCommand < Notifier
  
  # Fulfill the use-case initiated by the given Notification.
  # 
  # In the Command Pattern, an application use-case typically
  # begins with some user action, which results in an Notification being broadcast, which 
  # is handled by business logic in the execute method of an Command.
  def execute(notification)
    #override if you want to do something on this event
  end
  
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
