module PagesHelper
  def header_class(controller_name, action_name)
    if controller.controller_name == 'pages' && controller.action_name == 'home'
      'navbar navbar-inverse hero'
    else
      'navbar navbar-inverse normal'
    end
  end
end
