class ConnectionController < ApplicationController
  skip_before_action :authorize

  def main
  end

  def walkthrough_pc
  end

  def walkthrough_mac
  end

  def walkthrough_linux
  end

  def walkthrough_android
  end
  
  def walkthrough_ios
  end
end
