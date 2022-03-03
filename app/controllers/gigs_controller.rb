class GigsController < ApplicationController
  before_action :set_gig, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_organizer, only: [:new, :create]
  before_action :check_ownership, only: [:edit, :update, :destroy]

  # GET /gigs or /gigs.json
  def index
    @gigs = Gig.all
  end

  # GET /gigs/1 or /gigs/1.json
  def show
  end

  # GET /gigs/new
  def new
    @gig = Gig.new
  end

  # GET /gigs/1/edit
  def edit
  end

  # POST /gigs or /gigs.json
  def create
    # @gig = Gig.new(name: gig_params[:name], date: gig_params[:date], area: gig_params[:area], tickets: gig_params[:tickets], price: gig_params[:price], user: current_user)
    # @gig = Gig.new(params[:user_id])
    @gig = Gig.create(gig_params)
    respond_to do |format|
      if @gig.save
        format.html { redirect_to gig_url(@gig), notice: "Gig was successfully created." }
        # format.json { render :show, status: :created, location: @gig }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gigs/1 or /gigs/1.json
  def update
    respond_to do |format|
      if @gig.update(gig_params)
        format.html { redirect_to gig_url(@gig), notice: "Gig was successfully updated." }
        # format.json { render :show, status: :ok, location: @gig }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gigs/1 or /gigs/1.json
  def destroy
    @gig.destroy

    respond_to do |format|
      format.html { redirect_to gigs_url, notice: "Gig was successfully destroyed." }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gig
      @gig = Gig.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gig_params
      params.require(:gig).permit(:name, :date, :area, :tickets, :price, :user_id)
    end

    # check if the user is an organizer before creating a new gig
    def is_organizer
      if !current_user.organizer?
        redirect_to gig_url, alert: "You have to be an organizer to create new gigs"
      end
    end

    def check_ownership
      if !current_user.admin? and !current_user.id==@gig.user_id
        redirect_to gig_url, alert: "You have to be a site admin or the gig owner to perform this action"
      end
    end
end
