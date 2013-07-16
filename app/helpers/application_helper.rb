module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def favorite_button stop_time
    if user_signed_in?
      if current_user.favorites.find_by_stop_time_id(stop_time.id)
        button_tag "<i class='icon-star'></i>".html_safe, class: "btn btn-small", onclick: "removeFromFavorites(#{stop_time.id})", title: "Remove from favorites", id: "fav_#{stop_time.id}"
      else
        button_tag "<i class='icon-star-empty'></i>".html_safe, class: "btn btn-small", onclick: "addToFavorites(#{stop_time.id})", title: "Add to favorites", id: "fav_#{stop_time.id}"
      end
    else
      button_tag "<i class='icon-star-empty'></i>".html_safe, class: "btn btn-small disabled", disabled: true, title: "You must be signed in."
    end
  end

end