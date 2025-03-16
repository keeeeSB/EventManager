class ReviewsController < ApplicationController
  before_action :set_review, only: [ :edit, :update, :destroy ]
  before_action :set_event

  def create
    @review = current_user.reviews.create!(review_params)
    flash[:success] = "レビューを投稿しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  def edit
    render partial: "reviews/edit_form", locals: { review: @review, event: @event }
  end

  def update
    @review.update!(review_params)
    redirect_to user_event_path(@event.user, @event)
  end

  def destroy
    @review.destroy!
    flash[:success] = "レビューを削除しました。"
    redirect_to user_event_path(@event.user, @event), status: :see_other
  end

  private

    def review_params
      params.require(:review).permit(:body, :rating).merge(event_id: params[:event_id])
    end

    def set_review
      @review = current_user.reviews.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
