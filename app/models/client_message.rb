class ClientMessage < ActiveRecord::Base
  before_create :autofill

  def autofill
    if self.text.nil?
      self.text = ""
    end
    if self.url.nil?
      self.url = "#"
    end
  end
end
