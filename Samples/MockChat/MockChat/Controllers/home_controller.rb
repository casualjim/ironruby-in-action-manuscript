require 'application_controller'

class HomeController < ApplicationController
  
  def index
    view '', 'layout'
  end
  
  def about
    view '', 'layout'
  end
  
end