class FriendshipsController < ApplicationController
  def create
    # todo
  end

  def destroy
    friendship = Friendship.find_by(user_id: current_user, friend_id: params[:id])
    friendship.destroy

    flash[:notice] = "You are no longer following #{friendship.friend.full_name}"
    redirect_to my_friends_path
  end
end
