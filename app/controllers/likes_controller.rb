class LikesController < ApplicationController
    before_action :find_tweeet, only: [:destroy]
    # before_action :find_like, only: [:destroy]

    def create
        if user_signed_in?
            @tweeet = Tweeet.find (params[:format])
            @tweeet.likes.create(user_id: current_user.id)
            redirect_to root_path
        else
            redirect_to root_path, alert: 'Para dar Like, debes iniciar sesión.'
        end
    end

    def destroy
            @like.destroy
            redirect_to root_path
    end

    private

    def find_tweeet
        @like = Like.find(params[:id])
    end

    def find_like
        @like = @tweeet.likes.find(params[:id])
    end

    def already_liked?
        Like.where(
            user_id: current_user.id,
            tweeet_id: params[:tweeet_id]
        ).exists?
    end

end