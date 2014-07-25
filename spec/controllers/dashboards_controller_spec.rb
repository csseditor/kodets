RSpec.describe DashboardsController, type: :controller do

  describe 'GET #index' do
    context 'when not signed in' do
      before(:each) { sign_in_teacher nil }

      it 'redirects to /' do
        get :index
        expect(response).to redirect_to '/'
      end
    end

    context 'when teacher signed in' do
      before(:each) { sign_in_teacher }

      it 'responds successfully with an HTTP 200 status code' do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status 200
      end

      it 'renders the teacher_dashboard template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
