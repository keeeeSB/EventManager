module ParticipationsHelper
  def participation_button(event, user)
    participation = event.participations.find_by(user_id: user.id)

    if participation
      case participation.status
      when "pending"
          link_to "参加取り消し",
          event_participation_path(event, participation),
          data: { turbo_method: :delete },
          class: "btn btn-sm btn-danger"
      when "approved"
          content_tag(:span, "承認済み", class: "badge bg-primary")
      when "rejected"
          content_tag(:span, "却下", class: "badge bg-danger")
      end
    else
      link_to "参加申し込み",
        event_participations_path(event),
        data: { turbo_method: :post },
        class: "btn btn-sm btn-outline-primary"
    end
  end
end
