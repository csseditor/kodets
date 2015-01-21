module UsersHelper
  # rubocop:disable ColonMethodCall
  # Returns the Gravatar (http://gravatar.com/) for the given user
  def gravatar_for(user, options = { size: 50, circle: false, class: '' })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    class_names = ['gravatar ' + options[:class].to_s]

    options[:circle] ? class_names.push('img-circle') :
                       class_names.push('img-rounded')

    image_tag(url, alt: user.name, class: class_names.join(' '))
  end
end
