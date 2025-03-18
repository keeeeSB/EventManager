class ParticipationsController < ApplicationController
  def create
    @participation = current_user.participations.create!(event_id: params[:event_id])
    flash[:success] = "参加申し込みを行いました。"
    redirect_to events_path
  end

  def destroy
    @participation = current_user.participations.find_by(event_id: params[:event_id])
    @participation.destroy!
    flash[:success] = "参加申し込みを取り消しました。"
    redirect_to events_path, status: :see_other
  end
end
