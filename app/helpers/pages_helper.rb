module PagesHelper
  def header_class
    if on_page 'pages', 'home'
      'navbar navbar-inverse hero'
    else
      'navbar navbar-inverse normal'
    end
  end
end
