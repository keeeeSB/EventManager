module FavoritesHelper
  def favorite_button(event, user)
    if event.favorites.exists?(user_id: user.id)
      link_to event_favorite_path(event, current_user.favorites.find_by(event_id: event.id)),
              data: { turbo_method: :delete } do
        image_tag "star-fill.svg", alt: "お気に入り解除", class: "me-2"
      end
    else
      link_to event_favorites_path(event), data: { turbo_method: :post } do
        image_tag "star.svg", alt: "お気に入り登録", class: "me-2"
      end
    end
  end
end
