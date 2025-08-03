class SellersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_seller

  def dashboard
  end

  def messages
    @messages = Message.where(seller_id: current_user.id).includes(:buyer, :listing)
  end

  private

  def ensure_seller
    unless current_user.seller?
      redirect_to root_path, alert: "Access denied. Only sellers allowed."
    end
  end
end
