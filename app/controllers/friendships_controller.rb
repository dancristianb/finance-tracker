class FriendshipsController < ApplicationController
  def create
    current_user.friendships.build(friend_id: params[:friend])
    if current_user.save
      flash[:notice] =
        "You are now friends with #{current_user.friendships.last.friend.full_name}!"
      redirect_to my_friends_path
    else
      flash[:alert] = 'Something went wrong...'
      redirect_to root_path
    end
  end

  def destroy
    friendship = Friendship.find_by(user_id: current_user, friend_id: params[:id])
    friendship.destroy

    flash[:notice] = "You are no longer following #{friendship.friend.full_name}"
    redirect_to my_friends_path
  end
end
