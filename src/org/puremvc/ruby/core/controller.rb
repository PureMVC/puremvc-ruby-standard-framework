# In PureMVC, the Controller class assumes these responsibilities:
# * Remembering which Command is intended to handle which Notification.
# * Registering itself as an Observer with the View for each Notification that it has an Command mapping for.
# * Creating instances of the proper Command to handle a given Notification when notified by the View.
# * Calling the Command's execute method, passing in the Notification. 
#  
# Your application must register any Commands with the Controller.
#
# The simplest way is to subclass Facade, and use its initializeController method to add your registrations. 
# 
# * Command refers to SimpleCommand or MacroCommand


class Controller
  attr_accessor :command_map, :view
  
  include Singleton
  
  # This Controller implementation is a Singleton, 
  # so you can not call the constructor 
  # directly, but instead call the static Singleton 
  # Factory method Controller.instance
  def initialize
    @command_map = {}
    initialize_controller
  end

  # Initialize the Singleton Controller instance.
  #
  # Called Automatically by the construcor.
  #
  # Note that if you are using a subclass of View in your application, you should also
  # subclass Controller and override the initialize_controller method in the following way:
  #
  # <tt>
  #   def initialize_controller
  #      @view = MyView.instance
  #   end
  # </tt>
  def initialize_controller
    @view = View.instance
  end
  
   # If a Command has previously been registered to handle a given Notification, then it is executed
  def execute_command(notification)
    return unless @command_map[notification.name]
    @command_map[notification.name].new().execute(notification)
  end
  
  
  # Register a particular Command class as the handler for a particular Notification.
  #
  # If a Command has already been registered to handle Notification's with this name, it is 
  # no longer user, the new Command is used instead.
  # 
  # The Observer for the new Command is only created if this is the first time a Command
  # has been registered for this Notification name.
  def register_command(notification_name, command_class)
    @view.register_observer( notification_name, Observer.new(:execute_command, self) );
    @command_map[notification_name] = command_class
  end
  
  # Check if a command is registered for a given Notification
  def has_command?(notification_name)
    !@command_map[notification_name].nil?
  end
  
  # Remove a previously registered Command for a given Notification
  def remove_command(notification_name)
    @view.remove_observer(notification_name, self)
    @command_map.delete(notification_name)
  end
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
