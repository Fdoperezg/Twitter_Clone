class FriendshipsController < ApplicationController
    before_action :authenticate_user!
   # before_action :find_user

    def create
        @tweeet = Tweeet.find(params[:tweeet_id])
        @friendship = Friendship.new(user: current_user, friendship_id: @tweeet.user.id)
        if @friendship.save
            redirect_to root_path
        else
            redirect_to root_path, notice: "Friendship couldn't be created"
        end 
    end

    def update
        @tweeet = Tweeet.find(params[:id])
        @friendship = Friendship.find_by(friendship_id: @tweeet.user.id)
        if @friendship.destroy
            redirect_to root_path
        else
            redirect_to root_path, notice: "Friendship couldn't be destroyed"
        end 
    end

    private

    def find_user
        @user = User.find(params[:user_id])
    end
end