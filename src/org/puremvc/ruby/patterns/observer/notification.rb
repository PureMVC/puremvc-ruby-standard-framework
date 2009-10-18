# PureMVC does not rely upon underlying event models such as the one provided with Flash.
# 
# The Observer Pattern as implemented within PureMVC exists to support event-driven 
# communication between the application and the actors of the MVC triad.
# 
# Notifications are not meant to be a replacement for Events. Generally, Mediator 
# implementors place event listeners on their view components, which they
# then handle in the usual way. This may lead to the broadcast of Notifications to 
# trigger Commands or to communicate with other Mediators. Proxy and Command
# instances communicate with each other and Mediators by broadcasting Notifications.
# 
# A key difference between UI Events and PureMVC Notifications is that Events
# follow the 'Chain of Responsibility' pattern, 'bubbling' up the display hierarchy 
# until some parent component handles the Event, while PureMVC Notifications follow
# a 'Publish/Subscribe' pattern. PureMVC classes need not be related to each other in a 
# parent/child relationship in order to communicate with one another using Notifications.
class Notification
  
  attr_accessor :body, :type
  attr_reader :name
  
  def initialize(name=nil, body=nil, type=nil)
    @name = name
    @body = body
    @type = type
  end
  
  # Get the string representation of the Notification instance.
  def to_s
    msg = "Notifcation Name: #{@name}"
    msg += "\nBody: #{@body.inspect}"
    msg += "\nType: #{@type.inspect}"
    msg
  end
  
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
