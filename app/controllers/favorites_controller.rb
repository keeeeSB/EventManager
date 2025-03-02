class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create!(event_id: params[:event_id])
    flash[:success] = "お気に入りに追加しました。"
    redirect_to events_path
  end

  def destroy
    @favorite = current_user.favorites.find_by(event_id: params[:event_id])
    @favorite.destroy!
    flash[:success] = "お気に入りを解除しました。"
    redirect_to events_path, status: :see_other
  end
end
