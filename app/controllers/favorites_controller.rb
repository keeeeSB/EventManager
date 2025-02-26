class FavoritesController < ApplicationController
  before_action :set_event

  def create
    @favorite = current_user.favorites.create!(event_id: event.id)
    flash[:success] = "お気に入りに追加しました。"
    redirect_to events_path
  end

  def destroy
    @favorite = current_user.favorites.find_by(event_id: event.id)
    @favorite.destroy!
    flash[:success] = "お気に入りを解除しました。"
    redirect_to events_path, status: :see_other
  end

  private

    def set_event
      event = Event.find(params[:id])
    end
end
