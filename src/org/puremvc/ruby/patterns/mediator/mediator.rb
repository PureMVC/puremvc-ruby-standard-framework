class Mediator < Notifier
  
  # The name of the Mediator
  # Typically, a Mediator will be written to serve one specific control or group
  # controls and so,will not have a need to be dynamically named.
  attr_reader :name
  attr_accessor :view
  
  def initialize(name="Mediator", view=nil )
    @name = name
    @view = view
  end
  
  # List the Notification names this Mediator is interested in being notified of.
  def list_notification_interests
    []
  end
  
  # Handle Notifications.
  # 
  # Typically this will be handled in a switch statement, with one 'case' entry 
  # per Notification the Mediator is interested in.
  def handle_notification(note)
    #override if you want to do something on this event
  end

  # Called by the View when the Mediator is registered
  def on_register
    #override if you want to do something on this event
  end

  # Called by the View when the Mediator is removed
  def on_remove
    #override if you want to do something on this event
  end
  
end