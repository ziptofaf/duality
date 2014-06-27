class ErrorsController < ApplicationController
skip_before_action :authorize
  def routing
   render :status => 404 and return
  end
  

end

