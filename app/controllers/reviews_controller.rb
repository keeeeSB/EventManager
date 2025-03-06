class ReviewsController < ApplicationController
  before_action :set_event

  def create
    @review = current_user.review.create!(event_id: params[:event_id])
    flash[:success] = "レビューを投稿しました。"
    redirect_to user_event_path(event.user, event)
  end

  def update
    @review = current_user.review.find_by(event_id: params[:event_id])
    @review.update!
    flash[:success] = "レビューを更新しました。"
    redirect_to user_event_path(event.user, event)
  end

  def destroy
    @review = current_user.review.find_by(event_id: params[:event_id])
    @review.destroy!
    flash[:success] = "レビューを削除しました。"
    redirect_to user_event_path(event.user, event), status: :see_other
  end

  private

    def set_event
      event = Event.find(params[:id])
    end
end
