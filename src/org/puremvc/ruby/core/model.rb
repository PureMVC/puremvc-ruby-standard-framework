# In PureMVC, the Model class provides access to model objects (Proxies) by named lookup. 
# 
# The Model assumes these responsibilities:
#  * Maintain a cache of Proxy instances.
#  * Provide methods for registering, retrieving, and removing Proxy instances.
# 
# Your application must register Proxy instances with the Model. 
# Typically, you use an Command to create and register Proxy
# instances once the Facade has initialized the Core actors.

class Model
  
  include Singleton
  attr_accessor :proxy_map

  
  # This Model implementation is a Singleton, so you can not call the constructor 
  # directly, but instead call the static Singleton Factory method Model.instance
  def initialize
    @proxy_map = {}
    initialize_model
  end
  
  
  # Initialize the Singleton Model instance.
  # 
  # Called automatically by the constructor, this is your opportunity to initialize the Singleton
  # instance in your subclass without overriding the constructor.
  def initialize_model
  end
  
  # Register a Proxy with the Model.
  def register_proxy(proxy)
    @proxy_map[proxy.name] = proxy
    proxy.on_register
  end
  
  # Retrieve a Proxy from the Model
  def retrieve_proxy(proxy_name)
    @proxy_map[proxy_name]
  end
  
  # Check if a Proxy is registered.
  def has_proxy?(proxy_name)
    !@proxy_map[proxy_name].nil?
  end
  
  # Remove a Proxy from teh Model.
  def remove_proxy(proxy_name)
    proxy = @proxy_map.delete(proxy_name)
    proxy.on_remove
    proxy
  end
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
