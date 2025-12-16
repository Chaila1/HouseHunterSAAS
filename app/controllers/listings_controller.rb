class ListingsController < ApplicationController
  before_action :authenticate_user, except: [ :index, :show ]
  before_action :set_listing, only: [ :show, :update, :destroy ]
  before_action :authorize_owner, only: [ :update, :destroy ]

  # GET /listings or /listings.json
  def index
    @listings = Listing.all
    render json: @listings.as_json(methods: :image_url)
  end

  # GET /listings/1 or /listings/1.json
  def show
    render json: @listing.as_json(methods: :image_url)
  end

  # POST /listings or /listings.json
  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      render json: @listing.as_json(methods: :image_url)
    else
      render json: { errors: @listing.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    if @listing.update(listing_params)
      render json: @listing.as_json(methods: :image_url)
    else
      render json: { errors: @listing.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def authorize_owner
      render json: { error: "Not authorized" }, status: :unauthorized unless @listing.user == current_user
    end

    # Only allow a list of trusted parameters through.
    def listing_params
    params.require(:listing).permit(:lister, :address, :beds, :baths, :catergory, :price, :image)
  end
end
