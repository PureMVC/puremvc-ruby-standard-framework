# A MacroCommand maintains an list of Command Class references called SubCommands
# 
# When execute is called, the MacroCommand instantiates and calls execute on each 
# of its SubCommands.Each SubCommand will be passed a reference to the original 
# Notification that was passed to the MacroCommand's execute method.
# 
# Unlike SimpleCommand, your subclass should not override execute, but instead, 
# should override the initialize_macro_command method, calling add_sub_command 
# once for each SubCommand to be executed.
class MacroCommand < Notifier
  
  # You should not need to define a constructor, 
  # instead, override the initialize_macro_command method.
  # 
  # If your subclass does define a constructor, be sure to call super.
  def initialize
    @sub_commands = []
    initialize_macro_command
  end
  
  # Initialize the MacroCommand.
  # 
  # In your subclass, override this method to initialize the MacroCommand's
  # SubCommand list with Command class references like this:
  # 
  # <tt>
  #	def initialize_macro_command
  #       add_sub_command( FirstCommand.new )
  #       add_sub_command( SecondCommand.new )
  #       add_sub_command( ThirdCommand.new )
  #     end
  # </tt>
  # 
  # Note that SubCommands may be MacroCommands or SimpleCommands.
  def initialize_macro_command
    raise NotImplementedError
  end
  
  # Add a SubCommand
  #
  #The Subcommands will be called in First In/First Out (FIFO) order.
  def add_sub_command(command)
    @sub_commands << command
  end
  
  # Execute this MacroCommand's Subcommands. The SubCommands will be called in First
  # In/First Out (FIFO) order.
  def execute(notification)
    @sub_commands.each do |command|
      command.new().execute(notification)
    end
  end
  
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
