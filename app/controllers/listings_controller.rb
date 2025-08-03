class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_buyer, only: [:index, :show]
  before_action :require_seller, only: [:new, :create, :edit, :update, :destroy]

  def index
    @listings = Listing.all

    if params[:category].present? && Listing::CATEGORIES.include?(params[:category])
      @listings = @listings.where(category: params[:category])
    end

    if params[:sort].present?
      direction = params[:sort] == "desc" ? :desc : :asc
      @listings = @listings.order(price: direction)
    end

    if params[:search].present?
      keyword = "%#{params[:search]}%"
      @listings = @listings.where("name ILIKE ? OR description ILIKE ?", keyword, keyword)
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.build(listing_params)
    if @listing.save
      redirect_to my_listings_path, notice: "Listing created successfully!"
    else
      render :new
    end
  end

  def edit
    @listing = current_user.listings.find(params[:id])
  end

  def update
    @listing = current_user.listings.find(params[:id])
    if @listing.update(listing_params)
      redirect_to my_listings_path, notice: "Listing updated!"
    else
      render :edit
    end
  end

  def destroy
    @listing = current_user.listings.find(params[:id])
    @listing.destroy
    redirect_to my_listings_path, notice: "Listing deleted!"
  end

  def my_listings
    @listings = current_user.listings
  end

  def contact
    @listing = Listing.find(params[:id])
    seller = @listing.user
    buyer_message = params[:message]
    Message.create!(
    content: buyer_message,
    buyer_id: current_user.id,
    seller_id: seller.id,
    listing_id: @listing.id
  )

    # Simulated action
    flash[:notice] = "Your message has been sent to #{seller.email} (simulated)."
    redirect_to listing_path(@listing)
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :price, :category, :image)
  end

  def require_seller
    unless current_user.role == 'seller'
      redirect_to my_listings_path, alert: "Access denied. Only sellers can do that."
    end
  end

  def require_buyer
    unless current_user&.role == 'buyer'
      redirect_to root_path, alert: "Access denied. Only buyers can view listings."
    end
  end
end
