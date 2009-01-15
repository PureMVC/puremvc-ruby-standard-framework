# In PureMVC, the View class assumes these responsibilities:
# 
# * Maintain a cache of IMediator instances.
# * Provide methods for registering, retrieving, and removing Mediators.
# * Notifiying Mediators when they are registered or removed.
# * Managing the observer lists for each Notification in the application.
# * Providing a method for attaching Observers to an Notification's observer list.
# * Providing a method for broadcasting an Notification.
# * Notifying the Observers of a given Notification when it broadcast.
class View
  include Singleton
  
  attr_accessor :mediator_map, :observer_map
  
  
  # This View implementation is a Singleton, so you should not call the constructor 
  # directly, but instead call the static Singleton Factory method View.instance.
  def initialize
    @mediator_map = {}
    @observer_map = {}
    initialize_view
  end
  
  # Initialize the Singleton View instance.
  # 
  # Called automatically by the constructor, this is your opportunity to initialize 
  # the Singleton instance in your subclass without overriding the constructor
  def initialize_view
  end
  
  # Register an Observer to be notified of Notifications with a given name.
  def register_observer(notification_name, observer)
    observers = @observer_map[notification_name]
    if observers.nil?
      @observer_map[notification_name] = observer
    else
      observers = Array(@observer_map[notification_name])
      observers << observer
      @observer_map[notification_name] = observers
    end
  end
  
  # Notify the Observers for a particular Notification.
  #
  # All previously attached Observers for this Notification's list are notified
  # and are passed a reference to the Notification in the order in which they were registered.
  def notify_observers(notification)
    observers = Array(@observer_map[notification.name])
    observers.each{|observer| observer.notify_observer(notification)}
  end
  
  # Remove the observer for a given notify context from an observer list for a given 
  # Notification name.
  def remove_observer(notification_name, observer)
    observers = @observer_map[notification_name]
    observers = [observers] unless observers.is_a?(Array)
    @observer_map[notification_name] = observers.reject { |o| o.compare_notify_context(observer) }
    @observer_map.delete(notification_name) if observers.size.zero?
  end
  
  # Register a Mediator instance with the View.
  # 
  # Registers the Mediator so that it can be retrieved by name and further interrogates
  # the mediator for its Notification interests.
  #
  # If the mediator returns any Notifiation name to be notified about, an Observer is created
  # encapsulating the Mediator instance's handle_notification method and registering it as an
  # Observer for all Notifications the Mediator is interested in.
  def register_mediator(mediator)
    unless @mediator_map[mediator.name]
      @mediator_map[mediator.name] = mediator
      observer = Observer.new(:handle_notification, mediator)
      mediator.list_notification_interests.each do |interest|
        register_observer(interest, observer)
      end
      mediator.on_register
    end
  end
  
  # Retrieve a mediator from the View.
  #
  # returns the previously registered Mediator with the given name.
  def retrieve_mediator(mediator_name)
    @mediator_map[mediator_name]
  end
  
  # Remove a Mediator from the View.
  #
  # returns the Mediator that was removed.
  def remove_mediator(mediator_name)
    mediator = @mediator_map[mediator_name]
    if mediator
      mediator.list_notification_interests.each do |interest|
        remove_observer(interest, mediator)
      end
      @mediator_map.delete(mediator_name)
      mediator.on_remove
    end
    mediator
  end
  
  # Check if a Mediator is registered or not.
  #
  # returns whether a Mediator is registered with the given name.
  def has_mediator?(mediator_name)
    !@mediator_map[mediator_name].nil?
  end
  
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
