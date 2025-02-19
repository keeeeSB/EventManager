class EventsController < ApplicationController
  def index
    @events = Event.all.order(start_time: :asc)
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
    @event = curren_uset.events.find(params[:id])
    if @event.update(event_params)

  end

  def destroy
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :start_time,
                                    :location, category_attributes: [:name])
    end
end
