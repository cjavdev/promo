class WaitlistUsersController < ApplicationController
  layout 'marketing'

  before_action :set_waitlist_user, only: %i[ edit update ]


  # GET /waitlist_users/new
  def new
    @waitlist_user = WaitlistUser.new
  end

  # GET /waitlist_users/1/edit
  def edit
  end

  # POST /waitlist_users or /waitlist_users.json
  def create
    @waitlist_user = WaitlistUser.new(waitlist_user_params)

    respond_to do |format|
      if @waitlist_user.save
        format.html { redirect_to edit_waitlist_user_url(@waitlist_user), notice: "Waitlist user was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waitlist_users/1 or /waitlist_users/1.json
  def update
    respond_to do |format|
      if @waitlist_user.update(waitlist_user_params)
        format.html { redirect_to waitlist_user_url(@waitlist_user), notice: "Waitlist user was successfully updated." }
        format.json { render :show, status: :ok, location: @waitlist_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @waitlist_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_waitlist_user
    @waitlist_user = WaitlistUser.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def waitlist_user_params
    params.require(:waitlist_user).permit(:email, :you_tube_channel_url)
  end
end
