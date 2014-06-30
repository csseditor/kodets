module ApplicationHelper
  def full_title(title, base = 'Kodets')
    (title.empty? ? base : "#{title} | #{base}").html_safe
  end
end
