RSpec.describe PagesController, type: :controller do
  describe 'GET #home' do
    context 'when teacher not signed in' do
      before(:each) { sign_in_teacher nil }

      it 'responds successfully with an HTTP 200 status code' do
        get :home
        expect(response).to be_success
        expect(response).to have_http_status 200
      end

      it 'renders the home template' do
        get :home
        expect(response).to render_template :home
      end
    end

    context 'when teacher signed in' do
      before(:each) { sign_in_teacher }

      it 'redirects to /dashboard' do
        get :home
        expect(response).to redirect_to :dashboard
      end
    end
  end

  describe 'GET #pricing' do
    it 'responds successfully with an HTTP 200 status code' do
      get :pricing
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders the pricing template' do
      get :pricing
      expect(response).to render_template :pricing
    end
  end

  describe 'GET #about' do
    it 'responds successfully with an HTTP 200 status code' do
      get :about
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders the about template' do
      get :about
      expect(response).to render_template :about
    end
  end

  describe 'GET #contact' do
    it 'responds successfully with an HTTP 200 status code' do
      get :contact
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders the contact template' do
      get :contact
      expect(response).to render_template :contact
    end
  end
end
