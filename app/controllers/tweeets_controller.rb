class TweeetsController < ApplicationController
  before_action :set_tweeet, only: [ :show, :edit, :update, :destroy, :retweet]
  before_action :authenticate_user!, except: [:index, :show, :news, :date, :create, :create_api_tweet]
  before_action :correct_user, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only:[:create_api_tweet]
 
  def index
    @tweeet = Tweeet.new
    @tweeets = Tweeet.page(params[:page])
    if params[:q]
      @tweeets = Tweeet.where("tweeet LIKE ?", "%#{params[:q]}%").order(created_at: :desc).page(params[:page])
    else current_user.nil?
        @tweeets = Tweeet.order(created_at: :desc).page(params[:page])
    end
  end

  def news
    tweeets = Tweeet.last(50)
    api_tweeets = helpers.into_hash(tweeets)
    render json: api_tweeets
  end

  def date
    date_one = params[:fecha1].to_date
    date_two = params[:fecha2].to_date
    date_tweeets = Tweeet.created_between(date_one, date_two)
    api_tweeets = helpers.into_hash_and_date(date_tweeets)
    render json: api_tweeets
  end

  def show
  end

  def new
  end

  def edit
    if @tweeet.user_id != current_user.id
      redirect_to root_path, notice: "You don't have permission to edit the Tweeet"
    end
  end

  def create
    @tweeet = current_user.tweeets.build(tweeet_params)

    respond_to do |format|
      if @tweeet.save
        format.html { redirect_to root_path, notice: "Tweeet was succesfully created" }
        format.json { render :show, status: :created, location: @tweeet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweeet.update(tweeet_params)
        format.html { redirect_to @tweeet, notice: "El Tweeet fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @tweeet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweeet.errors, status: :unprocessable_entity }
      end
    end
  end

  def retweet
    origin = Tweeet.find(params[:id])
    retweet = Tweeet.new(tweeet: origin.tweeet, user: current_user, tweeet_id: origin.id)
    if retweet.save
      redirect_to root_path, notice: 'Has retuiteado exitosamente'
    else
      redirect_to root_path, notice: 'Ya lo has retuiteado!'
    end
  end

  def destroy
    @tweeet.destroy
    respond_to do |format|
      format.html { redirect_to tweeets_url, notice: "Tweeet was deleted succcesfully" }
      format.json { head :no_content }
    end
  end

  def correct_user
    @tweeets = current_user.tweeets.find_by(id: params[:id])
    redirect_to tweeets_path, notice: "Not authorized to edit this tweeet" if @tweeets.nil?
  end

  private
    def set_tweeet
      @tweeet = Tweeet.find(params[:id])
    end

    def tweeet_params
      params.require(:tweeet).permit(:tweeet)
    end
end