module ApplicationHelper
  def gravatar
    gravatar_id = Digest::MD5.hexdigest(current_user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: "your avatar", class: "h-8 w-8 rounded-full")
  end

  def menu_items
    [{
      name: 'Sources',
      controller: 'sources',
      path: '/sources',
    }, {
      name: 'Videos',
      controller: 'you_tube_videos',
      path: '/you_tube_videos',
    }, {
      name: 'Training samples',
      controller: 'training_samples',
      path: '/training_samples',
    }].map do |item|
      if controller.controller_name == item[:controller]
        item.merge(active: true)
      else
        item
      end
    end
  end
end
