class EventsController < ApplicationController
  before_action :set_event, only: [ :edit, :update, :destroy ]
  before_action :set_categories, only: [ :new, :create, :edit, :update ]

  def index
    @events = Event.includes(:user, :category).order(start_time: :asc)
  end

  def new
    @event = current_user.events.build
    @event.build_category
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "イベントを作成しました。"
      redirect_to user_event_path(current_user, @event)
    else
      flash.now[:danger] = "イベントを作成できませんでした。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      flash[:success] = "イベント情報を更新しました。"
      redirect_to user_event_path(current_user, @event)
    else
      flash.now[:danger] = "イベント情報を更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy!
    flash[:success] = "イベントを削除しました。"
    redirect_to root_path, status: :see_other
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :start_time,
                                    :location, :category_id, category_attributes: [ :name ])
    end

    def set_event
      @event = current_user.events.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end
end
