class TweeetsController < ApplicationController
  before_action :set_tweeet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /tweeets or /tweeets.json
  def index
    @tweeets = Tweeet.all.order(created_at: :desc)
    @tweeet = Tweeet.new
    @tweeets = Tweeet.page params[:page]
  end

  # GET /tweeets/1 or /tweeets/1.json
  def show
  end

  # GET /tweeets/new
  def new
    @tweeet = current_user.tweeets.build
  end

  # GET /tweeets/1/edit
  def edit
    if @tweeet.user_id != current_user.id
      redirect_to root_path, alert: 'No tienes permiso para editar el Tweeet'
    end
  end

  # POST /tweeets or /tweeets.json
  def create
    @tweeet = current_user.tweeets.build(tweeet_params)

    respond_to do |format|
      if @tweeet.save
        format.html { redirect_to root_path, notice: "Tweeet was successfully created." }
        format.json { render :show, status: :created, location: @tweeet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweeets/1 or /tweeets/1.json
  def update
    respond_to do |format|
      if @tweeet.update(tweeet_params)
        format.html { redirect_to @tweeet, notice: "Tweeet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweeet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  def retweet
    @retweet = Tweet.new(
      user_id: current_user.id,
      content: @tweet.content,
      tweet_id: @tweet.id
    )

    if @retweet.save
      redirect_to root_path, notice: 'Has retwiteado exitosamente'
    else
      redirect_to root_path, alert: 'Ya lo has retwiteado!'
    end
  end

  # DELETE /tweeets/1 or /tweeets/1.json
  def destroy
    @tweeet.destroy
    respond_to do |format|
      format.html { redirect_to tweeets_url, notice: "Tweeet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @tweeets = current_user.tweeets.find_by(id: params[:id])
    redirect_to tweeets_path, notice: "Not authorized to edit this tweeet" if @tweeets.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeet
      @tweeet = Tweeet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweeet_params
      params.require(:tweeet).permit(:tweeet)
    end
end
