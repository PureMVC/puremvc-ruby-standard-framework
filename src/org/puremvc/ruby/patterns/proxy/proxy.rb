# In PureMVC, Proxy classes are used to manage parts of the application's data model.
# 
# A Proxy might simply manage a reference to a local data object, in which case 
# interacting with it might involve setting and getting of its data in synchronous 
# fashion.
# 
# Proxy classes are also used to encapsulate the application's interaction with 
# remote services to save or retrieve data, in which case, we adopt an asyncronous 
# idiom; setting data (or calling a method) on the Proxy and listening for a 
# Notification to be sent when the Proxy has retrieved the data from the service.
class Proxy < Notifier
  
  attr_accessor :data
  attr_reader :name
  def initialize(proxy_name, data=nil)
    @name = proxy_name
    @data = data
  end
  
  # Called by the Model when the Proxy is registered
  def on_register
    #override if you want to do something on this event
  end

  # Called by the Model when the Proxy is removed
  def on_remove
    #override if you want to do something on this event
  end

end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
