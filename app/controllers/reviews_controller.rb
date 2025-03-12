class ReviewsController < ApplicationController
  before_action :set_event

  def create
    @review = current_user.reviews.create!(review_params)
    flash[:success] = "レビューを投稿しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  def update
    @review = current_user.reviews.find_by(event_id: @event.id)
    @review.update!(review_params)
    flash[:success] = "レビューを更新しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  def destroy
    @review = current_user.reviews.find_by(event_id: @event.id)
    @review.destroy!
    flash[:success] = "レビューを削除しました。"
    redirect_to user_event_path(@event.user, @event), status: :see_other
  end

  private

    def review_params
      params.require(:review).permit(:body, :rating).merge(event_id: params[:event_id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
