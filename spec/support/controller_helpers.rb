module ControllerHelpers
  def sign_in_teacher(teacher = double('teacher'))
    if teacher.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(
        :warden,
        {scope: :teacher}
      )
      allow(controller).to receive(:current_teacher).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(teacher)
      allow(controller).to receive(:current_teacher).and_return(teacher)
    end
  end
end
