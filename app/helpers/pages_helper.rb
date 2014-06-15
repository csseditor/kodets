module PagesHelper
  def header_class
    if controller.controller_name == 'pages' && controller.action_name == 'home'
      'navbar navbar-inverse hero'
    else
      'navbar navbar-inverse normal'
    end
  end
end
