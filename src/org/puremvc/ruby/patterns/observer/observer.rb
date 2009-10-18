# An Observer is an object that encapsulates information about an interested object 
# with a method that should be called when a particular Notification is broadcast.
# 
# In PureMVC, the Observer class assumes these responsibilities:
# * Encapsulate the notification (callback) method of the interested object.
# * Encapsulate the notification context (this) of the interested object.
# * Provide methods for setting the notification method and context.
# * Provide a method for notifying the interested object.
class Observer
  attr_accessor :notify, :context
  
  # The notification method on the interested object should take 
  # one parameter of type Notification
  def initialize(notify=nil, context=nil)
    @notify = notify
    @context = context
  end
  
  # Notify the interested object.
  def notify_observer(notification)
    @context.method(@notify).call(notification)
  end
  
  # Compare an object to the notification context.
  def compare_notify_context(object)
    @context.equal?(object)
  end
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
