module ApiHelper

  def readClientMessage
    message = ClientMessage.first
    return message
  end
end
