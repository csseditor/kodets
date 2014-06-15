module PagesHelper
  def clear_header?
    controller.controller_name == 'pages' && controller.action_name == 'home'
  end
end
