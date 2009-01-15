# In PureMVC, the Facade class assumes these responsibilities:
# 
# * Initializing the Model, View and Controller Singletons. 
# * Providing all the methods defined by the Model, View, & Controller.
# * Providing the ability to override the specific Model, View and Controller Singletons created. 
# * Providing a single point of contact to the application for registering Commands and notifying Observers
class Facade
  include Singleton
  
  attr_accessor :model, :view, :controller
  
  # This Facade implementation is a Singleton, so you can not call the constructor 
  # directly, but instead call the static Singleton Factory method Facade.instance
  def initialize
    initialize_facade
  end
  
  # Initialize the Singleton Facade instance.
  # 
  # Called automatically by the constructor. Override in your
  # subclass to do any subclass specific initializations. Be sure to call super.
  def initialize_facade
    initialize_model
    initialize_view
    initialize_controller
  end
  
  # Initialize the Controller.
  # 
  # Called by the initialize_facade method.
  # Override this method in your subclass of Facade if one or both of the following are true:
  # * You wish to initialize a different Controller.
  # * You have Commands to register with the Controller at startup.		  
  # 
  # If you don't want to initialize a different Controller, 
  # call super at the beginning of your method, then register Commands.
  def initialize_controller
    return unless @controller.nil?
    @controller = Controller.instance
  end
  
  # Initialize the Model.
  # 
  # Called by the initialize_facade method.
  # Override this method in your subclass of Facade if one or both of the following are true:
  # * You wish to initialize a different Model.
  # * You have Proxys to register with the Model that do not retrieve a reference to 
  # the Facade at construction time.
  # 
  # If you don't want to initialize a different Model, 
  # call super at the beginning of your method, then register Proxys.
  # 
  # Note: This method is rarely overridden; in practice you are morelikely to use a
  # Command to create and register Proxys with the Model, since Proxys with mutable
  # data will likely need to send Notifications and thus will likely want to fetch a 
  # reference to the Facade during their construction. 
  def initialize_model
    return unless @model.nil?
    @model = Model.instance
  end
  
  
  # Initialize the View.
  # 
  # Called by the initialize_facade method.
  # Override this method in your subclass of Facade if one or both of the following are true:
  # * You wish to initialize a different View.
  # * You have Observers to register with the View.
  # 
  # If you don't want to initialize a different View, call super at the beginning of your
  # method, then register Mediator instances.
  # 
  # Note: This method is rarely overridden; in practice you are more likely to use a 
  # Command to create and register Mediators with the View, since Mediator instances 
  # will need to send Notifications and thus will likely want to fetch a reference 
  # to the Facade during their construction. 
  def initialize_view
    return unless @view.nil?
    @view = View.instance
  end
  
  # Register an Command with the Controller by Notification name.
  def register_command(name, command_class_ref)
    @controller.register_command(name, command_class_ref)
  end
  
  # Remove a previously registered Command to Notification mapping from the Controller.
  def remove_command(notification_name)
    @controller.remove_command(notification_name)
  end
  
  # Check if a Command is registered for a given Notification 
  def has_command?(notification_name)
    @controller.has_command?(notification_name)
  end
  
  # Register a Proxy with the Model by name.
  def register_proxy(proxy)
    @model.register_proxy(proxy)
  end
  
  # Retrieve a Proxy with the Model by name.
  def retrieve_proxy(proxy_name)
    @model.retrieve_proxy(proxy_name)
  end
  
  # Remove an Proxy from the Model by name.
  def remove_proxy(proxy_name)
    proxy = @model.remove_proxy(proxy_name) unless @model.nil?
    proxy
  end
  
  # Check if a Proxy is registered
  def has_proxy?(proxy_name)
    @model.has_proxy?(proxy_name)
  end
  
  # Register a Mediator with the View.
  def register_mediator(mediator)
    @view.register_mediator(mediator) unless @view.nil?
  end
  
  # Retrieve a Mediator from the View.
  def retrieve_mediator(mediator_name)
    @view.retrieve_mediator(mediator_name)
  end
  
  # Remove a Mediator from the View.
  def remove_mediator(mediator_name)
    mediator = @view.remove_mediator(mediator_name) unless @view.nil?
    mediator
  end
  
  # Check if a Mediator is registered or not
  def has_mediator?(mediator_name)
    @view.has_mediator?(mediator_name)
  end
  
  # Create and send a Notification.
  # 
  # Keeps us from having to construct new notification 
  # instances in our implementation code.
  def send_notification(notification_name, body=nil, type=nil)
    notify_observers(Notification.new(notification_name, body, type))
  end
  
  # Notify Observers.
  # 
  # This method is left public mostly for backward compatibility, and to allow 
  # you to send custom notification classes using the facade.
  # 
  # Usually you should just call send_notification and pass the parameters, 
  # never having to construct the notification yourself.
  def notify_observers(notification)
    @view.notify_observers(notification) unless @view.nil?
  end
  
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
