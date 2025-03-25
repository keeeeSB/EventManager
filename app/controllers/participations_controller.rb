class ParticipationsController < ApplicationController
  before_action :set_event
  before_action :set_participation, only: [ :destroy, :approve, :reject ]

  def create
    @participation = current_user.participations.create!(event_id: @event.id)
    flash[:success] = "参加申し込みを行いました。"
    redirect_to events_path
  end

  def destroy
    @participation.destroy!
    flash[:success] = "参加申し込みを取り消しました。"
    redirect_to events_path, status: :see_other
  end

  def approve
    @participation.update(status: "approved")
    flash[:success] = "参加申し込みを承認しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  def reject
    @participation.update(status: "rejected")
    flash[:success] = "参加申し込みを拒否しました。"
    redirect_to user_event_path(@event.user, @event)
  end

  private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_participation
      @participation = current_user.participations.find_by(event_id: @event.id)
    end

    def authorize_event_owner
      unless @event.user == current_user
        flash[:danger] = "権限がありません。"
        redirect_to @event
      end
    end
end
