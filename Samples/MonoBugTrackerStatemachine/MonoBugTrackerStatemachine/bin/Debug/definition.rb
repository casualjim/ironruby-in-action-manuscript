require 'rubygems'
require 'statemachine'

inserted = ctxt

Statemachine.build do
  trans :open,     :assign, :assigned, :on_assigned
  trans :assigned, :close,  :closed
  trans :assigned, :defer,  :deferred
  
  superstate :open do
    state :assigned do
      event :assign, :assigned, :on_assigned      
      on_exit :deassigned
    end 
  end 
  
  state :deferred do
    event :assign, :assigned, :on_assigned
    on_entry :deassign
  end 
  
  context inserted
end 

