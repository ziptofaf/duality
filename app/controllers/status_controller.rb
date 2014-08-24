class StatusController < ApplicationController
  def server
    @servers = Server.all
  end
end
