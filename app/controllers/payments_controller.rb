class PaymentsController < ApplicationController
  before_action :admin_authorize
  def show
    @payments = Payment.all.limit(20).order(updated_at: :desc)
  end
end
